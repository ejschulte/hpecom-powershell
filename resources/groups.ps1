class Groups : Resource{
  
    [string]$uri = "/compute-ops/v1beta2/groups"

    #Constructors
    Groups(){}

    [object[]]GetDevices(){
        if(!$this.data){
            throw "Current group object contains no resource data. Retrieve the group resource with GetByName or GetById"
       }
       $_uri = "$($this.Connection.Endpoint)$($this.data.resourceUri)" + "/devices"
       $devices = $this.apiCall([Method]::GET, $_uri, '', '', '', '')
       return $devices.items
    }

    [object[]]GetDevicesCompliance(){
        if(!$this.data){
            throw "Current group object contains no resource data. Retrieve the group resouce with GetByName or GetById"
       }
       $_uri = "$($this.Connection.Endpoint)$($this.data.resourceUri)" + "/compliance"
       $devices = $this.apiCall([Method]::GET, $_uri, '', '', '', '')
       return $devices.items
    }
}