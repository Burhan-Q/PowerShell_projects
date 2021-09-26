#search for all image types inside of current directory
$imgs = Get-ChildItem *.jpg,*.png,*.gif,*.jpeg,*.bmp,*.tiff,*.tif

#initialize counter for index
$k = 0

#loop over each image, change 'BaseName' text to name applicable to image set
foreach($i in $imgs)
{
    #get file extension and save for later use
    $ext = $i.Extension
    
    #create new item name and add padded number
    $newname = ('BaseName' + '-' + ("{0:000}" -f $k) + $ext)
    
    #rename each item
    Rename-Item $i -NewName $newname
    
    #increase counter index
    $k++
}


# Add fake comment for testing branch/pull-request demo
