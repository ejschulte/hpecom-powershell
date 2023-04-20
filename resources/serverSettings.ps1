class ServerSettings : Resource{
  
    [string]$uri = "/compute-ops/v1beta1/server-settings"

   #Constructors
   ServerSettings(){}

   [Object[]]Get([string[]]$filter){
        
        $retval = $this.apiCall([Method]::GET, '', '', $filter, '', '')
        $this.data = $null
        return $retval.items
    }

    hidden[void]Get([string[]]$filter, [string]$offset, [string]$limit){
        Write-Warning "Method not supported by $($this.gettype().name) resource.  Use alternative GET method."   
    }
        

   [Object]GetByField([string]$fieldName, [string]$fieldValue){
        $q = @("$fieldName eq `'$fieldValue`'")
        $_uri = "$($this.Connection.Endpoint)$($this.uri)"
        $retval = $this.apiCall([Method]::GET, $_uri, '', $q, '', '')
        return $retval.items
    }
}

