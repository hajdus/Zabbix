<#
.SYNOPSIS
   
.DESCRIPTION


.NOTES
    autor: hajduk 2019
#>

#


 
  
  $server = "servername"
  

  $username = "app_zabbix"
  $password = "password"


$sql = "SELECT 
	  b.[name],
      [last_run_outcome]  = case when a.last_run_outcome = 0 then 'Failed'
	        when a.last_run_outcome = 1 then 'Succeeded'
	        when a.last_run_outcome = 2 then 'Retry'
	        when a.last_run_outcome = 3 then 'Canceled'
            when a.last_run_outcome = 4 then 'Running'
	        else 'Unknown'
	       end,
      a.[last_run_date],
      a.[last_run_time],
      a.[last_run_duration]
	  
  FROM [msdb].[dbo].[sysjobservers] as a
  LEFT OUTER JOIN [msdb].[dbo].[sysjobs] as b
   ON a.job_id = b.job_id 
  WHERE b.[enabled] = 1 
  AND a.[last_run_outcome]<> 1
  AND  a.[last_run_outcome] <> 4
  AND a.[last_run_date] <> 0 "

 $AccountToBlock =''
  
  try {
   $AccountToBlock = Invoke-Sqlcmd -Query $sql -ServerInstance $server -QueryTimeout 30 -ErrorAction 'Stop'  -username $username -password $password
   } 
  catch {
  Write-Error "ERROR!!" -EA Stop
 
   }

  
  $idx = 1

write-host "{"
write-host " `"data`":["
foreach ($name in $AccountToBlock)
{
    if ($idx -lt $AccountToBlock.Rows.Count)
        {
            #$line= "{ `"{#JOBNAME}`" : `"" + $name.name + "`", "  + "`"{#JOBSTATUS}`" : `"" + $name.last_run_outcome + "`" }," 
           
            $line= "{ `"{#JOBNAME}`" : `"" + $name.name + "`", "  + "`"{#JOBSTATUS}`" : `"" + $name.last_run_outcome + "`"}," 
            
            write-host $line
        }
    # Ostatni wiesz JSONA
    elseif ($idx -ge $AccountToBlock.Rows.Count)
        {
            $line= "{ `"{#JOBNAME}`" : `"" + $name.name + "`", "  + "`"{#JOBSTATUS}`" : `"" + $name.last_run_outcome + "`"}" 
            write-host $line
        }
    $idx++;
}

#write-host
write-host " ]"
write-host "}"




