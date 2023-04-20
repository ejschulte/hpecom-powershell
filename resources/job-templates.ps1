class JobTemplates : Resource{
  
    static[string]$uri = "/compute-ops/v1beta2/job-templates"
    static[Object]$ComJobTemplates = @{
        PowerOn = "0cbb2377-1834-488d-840c-d5bf788c34fb"
        #SppUpdate = "2626e682-7bd4-40e3-b93a-745133deecd2"
        #GroupFirmwareCompliance = "23b8ba2a-6c46-4223-b028-919382c7dcac"
        #GetSettingsForTemplate = "6cd671db-ce6b-45ce-894e-7b5ae23e0399"
        Restart = "30110551-cad6-4069-95b8-dbce9bbd8525"
        ColdBoot = "aacfb3e0-6575-4d4f-a711-1ee1ae768407"
        PowerOff = "d0c13b58-748c-461f-9a61-c0c5c71f1bb4"
        FirmwareUpdate = "fd54a96c-cabc-42e3-aee3-374a2d009dba"
        #GroupAddActions = "7983f2de-1ea7-4399-91ec-62d3647409e0"
        IloOnlyFirmwareUpdate = "94caa4ef-9ff8-4805-9e97-18a09e673b66"
        GroupFirmwareUpdate = "91159b5e-9eeb-11ec-a9da-00155dc0a0c0"
        #DataRoundupReportOrchestrator = "b0001d36-6490-48ac-93af-a87adfb997ed"
        #ApplySettingsTemplate = "2d0f40f7-2a07-4c74-92e1-d1afaf49e632"
        GroupStorageVolumeConfiguration = "c708eb57-235d-4ea8-9e21-8ceea2438773"
        GroupApplyServerSettings = "beff07ce-f36d-4699-9ac3-f872dcd63133"
        #GroupOSInstallation = "e2952628-2629-4088-93db-91742304ef0c"
        CreateOneviewComplianceReport = "aae145a1-79a2-4516-b191-c98039c96542"
    }
    #Constructors
    JobTemplates(){}

    [Object[]]Get([string]$offset, [string]$limit){

        $retval = $this.apiCall([Method]::GET, '', '', '', $offset, $limit)
        return $retval.items
    }

    [void]Get([string[]]$filter, [string]$offset, [string]$limit){
        
        Write-Warning "Search filters not supported on the $($this.gettype().name) resource. Use alternative GET method."
    }

    hidden[void]GetByName([string]$name){

        Write-Warning "GetByName not suported on the $($this.gettype().name) resource"
    }

    hidden[void]GetByField(){

        Write-Warning "GetByField not supported on the $($this.gettype().name) resource."

    }
}

