class Activities : Resource{
  
    [string]$uri = "/compute-ops/v1beta2/activities"

    #Constructors
    Activities(){}

    hidden[void]GetByName([string]$name){
        Write-Warning "Method, GetByName not supported on the $($this.gettype().name) resource."
    }

    hidden[void]GetById([string]$resourceId){
        Write-Warning "Method, GetById not supported on the $($this.gettype().name) resource."
    }

}