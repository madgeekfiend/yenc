class YEnc

  def initialize filepath
    @filepath = filepath
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
          end
          #end of reading lines
          #Decode and write to binary file
        end
      end
    else
      puts "This is not a yEncoded file."
    end
  end

  #EVERYTHING AFTER THIS IS PRIVATE
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