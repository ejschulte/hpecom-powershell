class Reports : Resource{
  
    [string]$uri = "/compute-ops/v1beta1/reports"

    #Constructors
    Reports(){}

    hidden[Object]GetByName([string]$name){
        return "Method, GetByName not supported on the $($this.gettype().name) resource."
    }

    [Object]GetCarbonFootprintReport(){

        $report = ($this.GetByField('reportType', 'CARBON_FOOTPRINT', '', '')).items
        $this.GetById("$($report.id)")
        $_reportDataUri = "$($this.connection.endpoint)$($this.data.reportDataUri)"
        $reportData = $this.apiCall([Method]::GET, $_reportDataUri, '', '', '', '')
        $this.data | Add-Member -NotePropertyName reportData -NotePropertyValue $reportData

        return $this
    }
}