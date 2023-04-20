
class Resource {

    #properties
    [Connection]$Connection
    [PSCustomObject]$Data
    hidden[string]$Caller

    #constructors
    Resource(){}

    [Object]GetByName([string]$name){
        $this.caller = [system.reflection.methodbase]::GetCurrentMethod().Name
        $_uri = "$($this.Connection.Endpoint)$($this.uri)"
        $q = @("name eq `'$name`'")
        $retval = $this.apiCall([Method]::GET, $_uri, '', $q, '', '')
        if($retval.count -ne 0){
            $this.data = $retval.items
        }
        else{
            Write-Warning "No $($this.gettype().name) resource found matching name: $name"
            $this.data = $null
        }
        return $this
    }

    [Object]GetById([string]$resourceId){
        $_uri = "$($this.Connection.Endpoint)$($this.uri)/$resourceId"
        $retval = $this.apiCall([Method]::GET, $_uri, '', '', '', '')
        if($retval){
            $this.data = $retval
        }
        else{
            Write-Warning "No $($this.gettype().name) resource found matching id: $resourceId"
            $this.data = $null
        }
        return $this
    }

    [Object]GetByField([string]$fieldName, [string]$fieldValue, [string]$offset, [string]$limit){
        $q = @("$fieldName eq `'$fieldValue`'")
        $_uri = "$($this.Connection.Endpoint)$($this.uri)"
        $retval = $this.apiCall([Method]::GET, $_uri, '', $q, $offset, $limit)
        $this.data = $null
        return $retval.items
    }

    [Object[]]Get([string[]]$filter, [string]$offset, [string]$limit){
        
        $retval = $this.apiCall([Method]::GET, '', '', $filter, $offset, $limit)
        $this.data = $null
        return $retval.items
    }

    [Object]Get(){

        if(!$this.data){
            throw "No valid object data found for $($this.gettype().name) resource."
        }
        $_uri = "$($this.Connection.Endpoint)$($this.data.resourceUri)"
        $retval = $this.apiCall([Method]::GET, $_uri, '', '', '', '')
        if($retval){
            $this.data = $retval
        }
        return $this
    }

    hidden[Object]apiCall([Method]$method, [string]$_uri, $requestBody, [string[]]$query, [string]$offset, [string]$limit){
        
        $headers = @{}
        $response = $null
        $headers["Authorization"]=$this.Connection.Jwt
        $restMethod = $method.ToString()

        if(!$this.Connection.Endpoint){
            throw "No endpoint set on the connection object. (i.e. https://us-west2-api.compute.cloud.hpe.com)"
        }

        if(!$_uri){
            $_uri = "$($this.Connection.Endpoint)$($this.URI)"
        }

        [string]$qstring = ""
        if($query){
            $i=0
            #$qstring = "?filter="
            if($query.count -eq 1){
                $qstring = $query
            }
            else{
                For($i -eq 0; $i -le ($query.count -1); $i++){
                    if($i -lt ($query.count -1)){
                        $qstring += "$($query[$i]) and "
                    }
                    else{
                        $qstring += $query[$i]
                    }
                }
            }
            $qstring = [System.Web.HttpUtility]::UrlEncode($qstring)
            $qstring = "?filter=$qstring"
            $_uri = $_uri + $qstring
            if($offset){$_uri = $_uri + "&" + "offset=$offset"}
            if($limit){$_uri = $_uri + "&" + "limit=$limit"}
        }
        else{
            if($offset){$_uri = $_uri + "?" + "offset=$offset"}
            if($limit -and $offset){$_uri = $_uri + "&" + "limit=$limit"}
            if($limit -and (!$offset)){$_uri = $_uri + "?" + "limit=$limit"}
        }
        
        switch ($restMethod)
        {
            "GET" {

            }
            "POST"{
                if($this.idempotencyKey){
                    $headers["idempotency-key"]=$this.idempotencyKey
                }
                $headers["Content-Type"]="application/json"
            }
            "PUT" {$headers["Content-Type"]="application/json"}
            "PATCH" {$headers["Content-Type"]="application/merge-patch.json"}
            "DELETE" {}
        }

        Write-Log "Method = $restmethod"
        Write-Log "URI = $_uri"
        Write-Log "Headers = $($headers.getenumerator())"
        Write-log "Request Body = $requestBody"
        Write-Log (Get-PSCallStack)[1]
        Try{
            if($requestBody){
                $response = Invoke-Webrequest -Uri $_uri -Method $restMethod -Headers $headers -body $requestBody
            }
            else{
                $response = Invoke-Webrequest -Uri $_uri -Method $restMethod -Headers $headers
            }
            
            #write-log "Response: $($response.content)"
        }
        catch{
            write-log $error[0].Exception
            write-log "$($this.gettype().name): $($this.caller)"
            Throw $_
        }
        return ($response.content | Convertfrom-Json)

    }

}