class YEnc

  def initialize filepath, outputpath
    @filepath = filepath
    @outputpath = outputpath
    puts "Searching for file: #{@filepath}"
  end

  def decode
    if is_yenc?
            #Continue decoding
      puts "File is verified as yEncoded file. Beginning decoding."
      begin_read = false

      File.open(@filepath, 'r').each_line do |line|

          puts "BEGIN_READ #{begin_read}"
          if line.include?("=ybegin") #This is the begin size
            breakdown_header line
            begin_read = true
            next
          end
          if line.include?("=yend")
            puts "Reached the end of file"
            break #stop looking through the file we are done
          end
          #end of reading lines

          if begin_read
            puts "Line count #{line.length}"
            #Decode and write to binary file
            esc = false
            line.each_byte do |c|
              if c == 61 #escape character hit goto the next one
                esc = true
                next
              elsif esc
                esc = false
                decoded = c - 64
              else
                decoded = c - 42
              end

              if decoded.between?(0,41)
                decoded = decoded + 214
              end
              #if decoded is 0 - 41 add 214
              @new_file.putc decoded
            end
          end

      end
      @new_file.close
    else
      puts "This is not a yEncoded file."
    end
  end

  private

  def is_yenc?
    File.read(@filepath).include?("=ybegin")
  end

  def breakdown_header line
    @filename=line[/name=(.*)/,1] if @filename.nil?
    @filesize =line[/size=([^\s]+)/,1] if @filesize.nil?
    @line=line[/line=([^\s]+)/,1] if @line.nil?
    puts "File Name: #{@filename}"
    puts "Size: #{@filesize} Length: #{@line}"
    puts "Creating file: #{@outputpath}#{@filename}"
    @new_file = File.new(@outputpath + @filename, "wb")
  end

end

y = YEnc.new("/Users/scontapay/yenc.txt", "/Users/scontapay/")
y.decode