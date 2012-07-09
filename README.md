# yEnc Decoder Gem

This gem provides decoding capablity of yEnc. You can find more documentation about yEnc at http://www.yenc.org. yEnc is used to encode Usenet binary files and convert them to ASCII.

# What is yEnc?

yEnc is a new encoding method which offers efficient and proper transmission for binaries on the Usenet (or by eMail and other applications).
Other encodings are BASE64, BinHex, UUencode, Quoted Printable, .....

yEnc is NOT an audio format (as MP3) or a video format (as AVI, MOV,...) or a picture format (as GIF or JPEG).

# Installation

    gem install yEnc

# How to use

This gem currently only supports decoding a single yEnc file. You can decode your yenc file by doing this.

```
require 'yEnc'

y = YEnc.new( full_path_to_yenc_text_file, path_to_output_binary_to )
y.decode
```

This will decode the yEnc ASCII text file to a binary file in the output path directory.

If you want to check if the generated binary has the expected crc32 signature from the yEnc file.

    y.pass_crc32?

# Getters

You can retrieve internal class data for these attributes

* filepath
* outputpath
* filename
* filesize
* line
* crc32

# History

* 0.0.27 - Cleaned up and removed puts calls and added pass_crc32? call
* 0.0.25 - First release with working decoder
* 0.0.20 - Initial commit to ruby gems not even working

