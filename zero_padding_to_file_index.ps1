#add zero padding to file index with format: label-##.ext

#get files in current directory
$files = (Get-ChildItem -file)

foreach ($f in $files)
{
#grab file extension for use when renaming
    $ext = $f.Extension
    
#split the base file name and cast the second part as an integer
    $first, [int]$second = $f.BaseName.Split('-')
    
#create padded number for three digits, if more digits needed, add more zeros after colon
#example- to add padding for 5 digits {0:00000}
    $padnum = "{0:000}" -f $second
    
#create new name using first part of basename, readding the hyphen, adding the padded number as a string, and reusing
#the original file extension
    $newname = $first + '-' + $padnum.ToString() + $ext
    
#rename file
    Rename-Item $f -NewName $newname
}
