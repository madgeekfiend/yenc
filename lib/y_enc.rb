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
      File.open(@filepath, 'r') do |f|
        f.any? do |line|
          if line.include?("=ybegin") #This is the begin size
            breakdown_header line
            next
          end
          #end of reading lines
          #Decode and write to binary file
          newFile = File.new(@filename, "w")
          escape = false

          line.each_byte do |c|
            if c == 61 #escape character hit goto the next one
              escape = true
              next
            elsif escape
              escape = false
              decoded = c - 64
            else
              decoded = c - 42
            end
            newFile.putc decoded
          end
          #done writing close the file
          newFile.close
        end
      end
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
  end

end