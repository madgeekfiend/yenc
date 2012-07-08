require 'zlib'

class YEnc

  def initialize filepath, outputpath
    @filepath = filepath
    @outputpath = outputpath
  end

  def decode
    if is_yenc?
            #Continue decoding
      begin_read = false

      File.open(@filepath, 'r').each_line do |line|

          if line.include?("=ybegin") #This is the begin size
            breakdown_header line
            begin_read = true
            next
          end
          if line.include?("=yend")
            begin_read=false
            break #stop looking through the file we are done
          end
          #end of reading lines

          if begin_read
            #puts "LINE COUNT: #{line.length}"
            #Decode and write to binary file
            esc = false
            line.each_byte do |c|
              next if c == 13 or c == 10

              if c == 61 and not esc #escape character hit goto the next one
                esc = true
                next
              else
                if esc
                  esc = false
                  c = c - 64
                end

                if c.between?(0,41)
                  decoded = c + 214
                else
                  decoded = c - 42
                end
              end
              @new_file.putc decoded
            end
          end

      end
      @new_file.close
    else
      false
    end
  end

  #Does this pass the crc32 check
  def pass_crc32?

  end

  private

  def is_yenc?
    File.read(@filepath).include?("=ybegin")
  end

  def breakdown_endline line
    @crc32 = line[/crc32=(.*)/,1] if @crc32.nil?
  end

  def breakdown_header line
    @filename=line[/name=(.*)/,1] if @filename.nil?
    @filesize =line[/size=([^\s]+)/,1] if @filesize.nil?
    @line=line[/line=([^\s]+)/,1] if @line.nil?
    @new_file = File.new(@outputpath + @filename, "wb")
  end

end