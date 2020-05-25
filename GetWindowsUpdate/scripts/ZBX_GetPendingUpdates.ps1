<#
.SYNOPSIS
   
.DESCRIPTION
.NOTES
    autor: hajduk 2019
#>

$AllObjects = @()
$AllUpdates = ("Security Updates")
        
        ForEach ($upd in $AllUpdates){
        $obj = new-object PSCustomObject
        Add-Member -InputObject $obj -MemberType NoteProperty -Name "UPNAME" -Value "$upd"
        Add-Member -InputObject $obj -MemberType NoteProperty -Name "UPNUMBER" -Value 0
        $AllObjects += $obj
        }
        
        $update = new-object -com Microsoft.update.Session
        $searcher = $update.CreateUpdateSearcher()
        $pending = $searcher.Search("IsInstalled=0")
        
        foreach($entry in $pending.Updates)
        {
            foreach($category in $entry.Categories)
            {
            if ($category.name -in $AllUpdates){
            ($AllObjects | ? {$_.upname -eq $category.name}).upnumber++
            }
          }
        }
           
 
  
  $idx = 0

write-host "{"
write-host " `"data`":["
foreach ($name in $AllObjects)
{
    if ($idx -lt $AllObjects.Rows.Count)
        {
            #$line= "{ `"{#JOBNAME}`" : `"" + $name.name + "`", "  + "`"{#JOBSTATUS}`" : `"" + $name.last_run_outcome + "`" }," 
           
            $line= "{ `"{#UPNAME}`" : `"" + $name.UPNAME + "`", "  + "`"{#UPNUMBER}`" : `"" + $name.UPNUMBER + "`"}," 
            
            write-host $line
        }
    # Ostatni wiesz JSONA
    elseif ($idx -ge $AccountToBlock.Rows.Count)
        {
            $line= "{ `"{#UPNAME}`" : `"" + $name.UPNAME + "`", "  + "`"{#UPNUMBER}`" : `"" + $name.UPNUMBER + "`"}" 
            write-host $line
        }
    $idx++;
}

#write-host
write-host " ]"
write-host "}"

