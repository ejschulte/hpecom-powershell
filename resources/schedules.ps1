class Schedules : Resource{
  
    [string]$uri = "/compute-ops/v1beta2/schedules"
    hidden[string]$idempotencyKey

    #Constructors
    Schedules(){
        $this.idempotencyKey = [guid]::NewGuid()
    }


}