ipmo .\hpecom.psd1

# Create a new Com API client and acquire JWT
$cc = New-ComClient "<Your COM Client ID>" "<Your COM Client Secret>"

# Set the appropriate endpoint
$cc.Connection.endpoint="https://us-west2-api.compute.cloud.hpe.com"

# Get all job-templates
$cc.JobTemplates.Get('','')

# List job template types and their ids
[JobTemplates]::ComJobTemplates

# Get a job template by id
$jt = $cc.JobTemplates.GetById([JobTemplates]::ComJobTemplates.PowerOff)

