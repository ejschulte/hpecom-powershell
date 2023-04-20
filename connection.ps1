
class Connection{
    
    [string]$ClientId
    hidden[string]$ClientSecret
    [string]$Jwt
    [string]$Endpoint

    Connection($clientId, $clientSecret){
        $headers = @{}
        $headers["Content-Type"] = "application/x-www-form-urlencoded"

        $body = "grant_type=client_credentials&client_id=$clientId&client_secret=$clientSecret"

        $response = Invoke-webrequest $global:loginUrl -Method POST -Headers $headers -Body $body

        $token = ($response.Content  | Convertfrom-Json).access_token

        $this.Jwt = "Bearer $token"
        $this.ClientId = $clientId
        $this.ClientSecret = $clientSecret
    }

    [void]SetEndpoint([string]$_endpoint){

        $this.Endpoint = $_endpoint
    }

}