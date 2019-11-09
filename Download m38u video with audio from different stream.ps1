#---------------------------------------
# Download .m3u8 video with audio from different stream
#
# Description:
# Script downloads a m3u8 stream and 
# converts the file to a mp4 file, downloads
# the audio from a seperate stream and joins
# the audio to the mp4 file.
# 
# The reason I made this is to resolve issues
# where a stream downloaded with no audio, this
# script detects the audio from the master.m3u8 
# and rips it seperatley.
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



#Download Audio TS file Procedure

(New-Object System.Net.WebClient).DownloadFile($url, "master.txt")

$audioLine = (Get-Content -Path 'master.txt' | Where-Object {$_ -like '#EXT-X-MEDIA:TYPE=AUDIO*' } )

$LI = ($audioLine[$audioLine.length-1].LastIndexOf('URI=')+5)
$LEN = $audioLine[$audioLine.length-1].length - ($LI + 1)

#Grab Audio URL
$AudioURL = $audioLine[$audioLine.length-1].Substring($LI,$LEN)

#Remove master.txt no longer needed
Remove-Item "master.txt"

ffmpeg -i $AudioURL -c copy -map a "outputaudio.ts"


ffmpeg -i $url -c copy -bsf:a aac_adtstoasc "output.mp4"
ffmpeg -i "output.mp4" -i "outputaudio.ts" -c:v copy -c:a aac -strict experimental -map 0:v:0 -map 1:a:0 $outputName

Remove-Item "outputaudio.ts"
Remove-Item "output.mp4"

pause