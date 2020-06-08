#Collect parameters from PrusaSlicer

#Get input from user
$file = (Read-Host "Drag and drop the .gcode file into this window that you'd like to analyze").split('"')[1]

#Read input file
[System.Collections.ArrayList] $gcode = Get-Content $file

#Set variables
$i = 0
$j = 0
$thumb_indx = {}.Invoke()
$layer_indx = {}.Invoke()
$full_count = $gcode.Count

#Display message
Write-Host "Please wait...parsing $($full_count) lines"

foreach($l in $gcode)
{

#Look for index of lines with thumbnail tag
   if($l -like "*thumbnail *")
   {
      $thumb_indx.Add($i)
   }

#Increase thumbnail counter
   $i++

#Provide occasional status updates
   if($i/$full_count -eq 0.25)
   {
      Write-Host "25% complete"
   }

   if($i/$full_count -eq 0.5)
   {
      Write-Host "50% complete"
   }

   if($i/$full_count -eq 0.75)
   {
      Write-Host "75% complete"
   }

   if($i/$full_count -eq 0.95)
   {
      Write-Host "95% complete"
   }

   if($i/$full_count -eq 0.99)
   {
      Write-Host "99% complete"
   }

#Look for index of starting print code
   if($l -like "* Filament gcode*")
   {
      $layer_indx.Add($j)
   }

#Look for index of ending print code
   if($l -like "* END gcode for*")
   {
      $layer_indx.Add($j)
   }

#Increase layer counter
   $j++

}

#map gcode to parameter list variable
$param_list = $gcode

#calculate number of printing command lines
$length = $layer_indx[-1] - $layer_indx[0]

#remove printing command lines
$param_list.RemoveRange($layer_indx[0], $length)

#calculate number of lines containing thumbnail information
$thumb_length = $thumb_indx[-1] - $thumb_indx[0]

#remove lines with thumbnail information
$param_list.RemoveRange($thumb_indx[0],$thumb_length)

#display output?
$display_output = Read-Host "Display output? Enter 'Y' or 'N'"

#check that input was in correct format
$correct_input = $false
while($correct_input -eq $false)
{
   if($display_output -ne 'Y' -and $display_output -ne 'N')
   {
   $correct_input = $false
   $display_output = Read-Host "Input not valid, please enter 'Y' or 'N' only"
   }
   else
   {
   $correct_input = $true
   }
}

#if set true, then load output display
if($display_output -eq 'Y')
{
   $param_list | Out-GridView
}
else
{
   continue
}

#output to CSV?
$CSV_output = Read-Host "Send output to CSV? Enter 'Y' or 'N'"

#check that input was in correct format
$correct_input = $false
while($correct_input -eq $false)
{
   if($CSV_output -ne 'Y' -and $display_output -ne 'N')
   {
   $correct_input = $false
   $CSV_output = Read-Host "Input not valid, please enter 'Y' or 'N' only"
   }
   else
   {
   $correct_input = $true
   }
}

#if set true, then send output to CSV on DESKTOP
if($CSV_output -eq 'Y')
{
   $name = ($file.Split('\')[-1]).replace('.','-')
   $param_list | Out-File $HOME\Desktop\$name.csv
   Write-Host "Thank you for using this G-Code parsing script. Find more scripts like this at github.com/Burhan-Q"
}
else
{
   Write-Host "Thank you for using this G-Code parsing script. Find more scripts like this at github.com/Burhan-Q"
   continue
}
