#shell script for automatically capturing screenshots

#multi-monitor setup, paramters for capturing central screen only
$width = 2560
$height = 1080
$left = 0
$top = 0

#establish save directory on desktop (Windows)
$path = $HOME + '\Desktop\'

#use today's date as destination folder
$date = get-date -Format "yyyy-MM-dd"
$savepath = $path + 'Auto-Screenshots\' + $date

#check if path exists, if not then create new directory for Auto-Screenshots and subdirectory using today's date
if (-not(Test-Path -Path $savepath))
{
  New-Item -Path $savepath -ItemType Directory
}

#initialize screencount capture counter
$i=0

#loops infinitely, manually break to halt script
while(1)
{
  #pause script for time in seconds specified
  Start-Sleep -Seconds 90

  #get timestamp
  $time = get-date -Format "yyyy-MM-dd_HH-mm-ss"
  #create filename with timestamp and map save directory
  $file = $savepath + '\screensave-' + $time + '.bmp'

  #create image based on screen parameters
  $bitmap = New-Object System.Drawing.Bitmap $width, $height
  #create graphic object
  $graphic = [System.Drawing.Graphics]::FromImage($bitmap)
  #capture screenshot
  $graphic.CopyFromScreen($left, $top, 0, 0, $bitmap.Size)

  #save screenshotimage
  $bitmap.Save($file)
  #increase counter
  $i++
  #display status message
  Write-Host 'Saved screenshot count = ' $i
}
