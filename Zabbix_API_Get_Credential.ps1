


if(!$credential){
    $credential = Get-Credential
}

$baseurl = 'http://ipaddress/zabbix/'
$params = @{
    body =  @{
        "jsonrpc"= "2.0"
        "method"= "user.login"
        "params"= @{
            "user"= $credential.UserName
            "password"= $credential.GetNetworkCredential().Password
        }
        "id"= 1
        "auth"= $null
    } | ConvertTo-Json
    uri = "$baseurl/api_jsonrpc.php"
    headers = @{"Content-Type" = "application/json"}
    method = "Post"
}
$result = Invoke-WebRequest @params
$result