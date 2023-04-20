class Filters : Resource{
  
    [string]$uri = "/compute-ops/v1beta1/filters"
    hidden[string]$idempotencyKey

    #Constructors
    Filters(){
        $this.idempotencyKey = [guid]::NewGuid()
    }

    [object[]]GetFilterResources(){
        if(!$this.data){
            throw "Current filter object contains no resource data. Retrieve the filter resource with GetByName or GetById"
       }
       $_uri = "$($this.Connection.Endpoint)$($this.data.resourceUri)" + "/matches"
       $devices = $this.apiCall([Method]::GET, $_uri, '', '', '', '')
       return $devices.items
    }

    [object[]]GetFilterableProperties(){
       $_uri = "$($this.Connection.Endpoint)$($this.Uri)" + "/properties"
       $devices = $this.apiCall([Method]::GET, $_uri, '', '', '', '')
       return $devices.items
    }
}