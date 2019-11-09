#---------------------------------------
# Download multiple .m3u8 videos
#
# Description:
# This modified script enables you to
# download multiple M3U8 video streams,
# this example demonstrated the use case
# of downloading a series of videos like
# a TV Series, where you can specify the 
# Season and Episode numbers.
#
# Prerequisite:
# Have ffmpeg installed with path set
# https://www.ffmpeg.org/download.html
#
# Script written by Luke Gackle
# https://lukestoolkit.blogspot.com
#
#---------------------------------------

$seriesName = Read-Host -Prompt "Enter Series Name"
$Season = Read-Host -Prompt "Enter Season Number i.e 1"
$Episode = Read-Host -Prompt "Enter Starting Episode Number i.e 1"
Write-Host ""
Write-Host "INFORMATION:"
Write-Host "You may now supply stream URLs, once you have provided all URLs, type stop to end the script."
Write-Host "A new PowerShell window will open to download each new stream."
Write-Host ""
while($url = (Read-Host -Prompt "Enter stream URL")){
    if($url -ne "stop"){
        $outputName = "$seriesName S0$Season E0$Episode.mp4"
        $Episode = $Episode + 1
        invoke-expression "cmd /c start powershell -NoExit -Command {
         ffmpeg -i $url -c copy -bsf:a aac_adtstoasc '$outputName';
        }";
        
    }
    else
    {
        break
    }
}