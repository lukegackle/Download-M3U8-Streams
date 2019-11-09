#---------------------------------------
# Download .m3u8 video
#
# Description:
# Script downloads a m3u8 stream and 
# converts the file to a mp4 file.
# MP4 file will be saved to the current 
# directory.
#
# Prerequisite:
# Have ffmpeg installed with path set
# https://www.ffmpeg.org/download.html
#
# Script written by Luke Gackle
# https://lukestoolkit.blogspot.com
#
#---------------------------------------

$url = Read-Host -Prompt "Enter stream URL"
$outputName = Read-Host -Prompt "Enter File Name e.g.(Include.mp4)"

ffmpeg -i $url -c copy -bsf:a aac_adtstoasc $outputName