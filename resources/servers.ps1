
class Servers : Resource{
  
     [string]$uri = "/compute-ops/v1beta2/servers"

    #Constructors
     Servers(){}

     [Object]GetByName([string]$name){
          $_uri = "$($this.Connection.Endpoint)$($this.uri)"
          $q = @("contains(host/hostname, `'$name`')")
          $retval = $this.apiCall([Method]::GET, $_uri, '', $q, '', '')
          if($retval.count -ne 0){
              $this.data = $retval.items
          }
          else{
              Write-Warning "No server resource found matching name: $name"
              $this.data = $null
          }
          return $this
     }
      

     [Object[]]GetAlerts(){

          $alerts = $this.getExtraData(1)
          return $alerts.items
     }

     [Object]GetNotifications(){
          
          $notifications = $this.getExtraData(2)
          return $notifications.items
     }

     [Object]GetRawInventory(){
          $inventory = $this.getExtraData(3)
          return $inventory
     }

     hidden[Object]getExtraData([ExtraData]$dataType){
          if(!$this.data){
               throw "Current server object contains no resource data. Retrieve the server resouce with GetByName or GetById"
          }
          $dataTypeString = $dataType.ToString()
          if($dataTypeString -match "inventory"){$dataTypeString = "raw-inventory"}
          $_uri = "$($this.Connection.Endpoint)$($this.data.resourceUri)" + "/$dataTypeString"
          $retval = $this.apiCall([Method]::GET, $_uri, '', '', '', '')
          return $retval
     }

     [Object]PowerOn(){
          if(!$this.data){
               throw "No valid server resource data found."
          }
          $_job = [Jobs]::New()
          $_job.connection = $this.connection
          $_job.Data = $_job.PowerOperation($this, [PowerOption]::PowerOn, [PowerOffOption]::None)
          return $_job
     }

     [Object]PowerOff(){
          if(!$this.data){
               throw "No valid server resource data found."
          }
          $_job = [Jobs]::New()
          $_job.connection = $this.connection
          $_job.Data = $_job.PowerOperation($this, [PowerOption]::PowerOff, [PowerOffOption]::None)
          return $_job
     }

     [Object]PowerOff([PowerOffOption]$option){
          if(!$this.data){
               throw "No valid server resource data found."
          }
          $_job = [Jobs]::New()
          $_job.connection = $this.connection
          $_job.Data = $_job.PowerOperation($this, [PowerOption]::PowerOff, $option)
          return $_job
     }

     [Object]Restart(){
          if(!$this.data){
               throw "No valid server resource data found."
          }
          $_job = [Jobs]::New()
          $_job.connection = $this.connection
          $_job.Data = $_job.PowerOperation($this, [PowerOption]::Restart, [PowerOffOption]::None)
          return $_job
     }

     [Object]ColdBoot(){
          if(!$this.data){
               throw "No valid server resource data found."
          }
          $_job = [Jobs]::New()
          $_job.connection = $this.connection
          $_job.Data = $_job.PowerOperation($this, [PowerOption]::ColdBoot, [PowerOffOption]::None)
          return $_job
     }
}

