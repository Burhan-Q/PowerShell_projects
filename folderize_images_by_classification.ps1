#sorting images based on CSV file classification

<#
place PS1 file into directory with *only* unsorted image files and classification CSV file
right click PS1 file and select "Run with Powershell"
follow prompts in terminal
#>

#set path as current directory
$path = (Get-Location).Path

#get all image type files from current path
$files = gci *.jpg,*.png,*.gif,*.jpeg, *.tif, *.tiff, *.bmp
#alternatively, use line below to get all files, just be aware it could cause errors later
#$files = gci -Path $path -file 

#grab data from CSV file
$cFile = Import-Csv (gci -file *.csv)

#select unique classifications (if CSV header is different, change 'Classification' to match CSV header)
$unique_class = $cFile.Classification | select -unique

#create a folder the in current directory for each unique classification type
foreach($u in $unique_class)
{
#check if path already exists
    if(!(Test-Path $u))
    {
#create new path if it doesn't already exist
        New-Item -Path $u -ItemType Directory
    }
    else
    {
        continue
    }
}

#use CSV data to move files to classification folder
foreach($l in $cFile)
{
#find the file matching the entry filename (if CSV header is different, change 'Filename' to match CSV header)
    $file = gci -filter ($l.Filename.ToString() + '*')
#get the classification
    $class = $l.classification.ToString()
#move the file to the correct classification folder
    $file | Move-Item -Destination $class
}

Read-Host -Prompt "Press enter to close terminal"
