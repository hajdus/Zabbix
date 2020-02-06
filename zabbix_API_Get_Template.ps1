

$baseurl = 'http://ipaddress/zabbix/'
$params = @{
    "body" =  @{
        "jsonrpc"= "2.0"
        "method"= "template.get"
        "params"= @{
         

         "output"= "extend"
        "filter" = @{
            "name"= "Template OS Windows"
               
            
        }


        }
        "id"= 1
        "auth"= "?????????"
    } | ConvertTo-Json
    "uri" = "$baseurl/api_jsonrpc.php"
    "headers" = @{"Content-Type" = "application/json"}
    "method" = "Post"
}

$result = Invoke-WebRequest @params
$result = $result.Content | ConvertFrom-Json |FL| Out-File -FilePath C:\Users\mh\Desktop\result.txt
$result 