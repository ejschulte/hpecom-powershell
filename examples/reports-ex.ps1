ipmo .\hpecom.psd1

# Create a new Com API client and acquire JWT
$cc = New-ComClient "<Your COM Client ID>" "<Your COM Client Secret>"

# Set the appropriate endpoint
$cc.Connection.endpoint="https://us-west2-api.compute.cloud.hpe.com"

# Get all reports
$allReports = $cc.Reports.Get('','','')
$allReports

# As of now only the carbon footprint report exists
# Get the carbon footprint report and output the report data
$cReport = $cc.Reports.GetCarbonFootprintReport()
$cReport.data.reportData