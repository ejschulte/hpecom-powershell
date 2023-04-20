
class Jobs : Resource{
  
    [string]$uri = "/compute-ops/v1beta3/jobs"

    #Constructors
    Jobs(){}

#region Get methods
    hidden[void]GetByName(){
        Write-Warning "GetByName not supported on the $($this.gettype().name) resource."
    }

    hidden[void]GetByField(){
        Write-Warning "GetByField not supported on the $($this.gettype().name) resource."
    }

    [Object[]]Get([string]$offset, [string]$limit){

        $retval = $this.apiCall([Method]::GET, '', '', '', $offset, $limit)
        $this.data = $null
        return $retval.items
    }

    [void]Get([string[]]$filter, [string]$offset, [string]$limit){
        
        Write-Warning "Search filters not supported on the $($this.gettype().name) resource"
    }
#endregion

#region Create job methods
    [Object]NewJob([string]$jobTemplateId, [string]$resourceUri, [Object]$data){
        
        $jobTemplateUri = [JobTemplates]::Uri
        switch($jobTemplateId){

            {[JobTemplates]::ComJobTemplates.values -match $_} {
                $jobTemplateUri +=  "/$jobTemplateId"
            }
            Default{
                throw "Invalid job template id: $jobTemplateId"
            }
        }

        $payload = @{
            jobTemplateUri = $jobTemplateUri
            resourceUri = $resourceUri
            data = $data
        }
        
        $body = $payload | Convertto-Json -Compress
        $_uri = "$($this.connection.endpoint)$($this.uri)"
        $retval = $this.apiCall([Method]::POST, $_uri, $body, '', '', '')
        $this.data = $retval
        return $this
    }

    # Server jobs called via server method

    hidden[Object]PowerOperation([Object]$server, [PowerOption]$option, [PowerOffOption]$offOption){
        if(!$server.data){
            throw "Not a valid server object."
        }

        $jobTemplateUri = [JobTemplates]::Uri

        switch($option.tostring()){

            "PowerOn"{
                $jobTemplateUri += "/" + [JobTemplates]::ComJobTemplates.PowerOn
            }
            
            "PowerOff"{
                if($offOption.tostring() -eq "None"){
                    $offOption = [PowerOffOption]::ForceOff
                }
                $jobTemplateUri += "/" + [JobTemplates]::ComJobTemplates.PowerOff
            }
            "Restart"{
                $jobTemplateUri += "/" + [JobTemplates]::ComJobTemplates.Restart
            }
            "ColdBoot"{
                $jobTemplateUri += "/" + [JobTemplates]::ComJobTemplates.ColdBoot
            }
            default{
                throw "Not a valid power operation"
            }
        }

        if($option.tostring() -eq "PowerOff"){
            $payload = @{
                jobTemplateUri = $jobTemplateUri;
                resourceUri = $server.data.resourceUri;
                data = @{
                    operationType = $offOption.tostring()
                }
                
            }
        }
        else{
            $payload = @{
                jobTemplateUri = $jobTemplateUri;
                resourceUri = $server.data.resourceUri
            }
        }

        $body = $payload | Convertto-Json -Compress
        $_uri = "$($this.connection.endpoint)$($this.uri)"
        $retval = $this.apiCall([Method]::POST, $_uri, $body, '', '', '')
        return $retval
    }

#endregion

}