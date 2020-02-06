

$baseurl = 'http://ipaddress/zabbix/'
$hostname = $env:computername
$ipaddress = [System.Net.Dns]::GetHostAddresses($hostname) | foreach { $_.IPAddressToString | findstr "10.110."}



$params = @{
     "body" =  @{
        "jsonrpc"= "2.0"
        "method"= "host.create"
        
        
        "params"= @{
          
        
        "host"= "$hostname";
        "interfaces" = @{
                "type"= 1;
                "main"= 1;
                "useip"= 1;
                "ip"= "$ipaddress";
                "dns"= "";
                "port"= "10050"
            };
        
        "groups"=@{
                "groupid"= "6"
            };
        
        "templates"=@{
                "templateid"= "10081"
            };
        


        }
        
        
        "id"= 1
        "auth"= "??????"
    } | ConvertTo-Json
    uri = "$baseurl/api_jsonrpc.php"
    headers = @{"Content-Type" = "application/json"}
    method = "Post"
}

$result = Invoke-WebRequest @params
$result = $result.Content | ConvertFrom-Json
$result