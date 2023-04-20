class FwBundles : Resource{
  
    [string]$uri = "/compute-ops/v1beta2/firmware-bundles"

    #Constructors
    FwBundles(){}

    [Object[]]Get([string]$offset, [string]$limit){

        $retval = $this.apiCall([Method]::GET, '', '', '', $offset, $limit)
        return $retval.items
    }

    [void]Get([string[]]$filter, [string]$offset, [string]$limit){
        
        Write-Warning "Search filters not supported on the $($this.gettype().name) resource. Use alternative GET method"
    }

    hidden[void]GetByName([string]$name){
        Write-Warning "GetByName not supported on the $($this.gettype().name) resource."
    }

    hidden[Void]GetByField([string]$fieldName, [string]$fieldValue, [string]$offset, [string]$limit){
        Write-Warning "GetByField not supported on the $($this.gettype().name) resource."
    }

}