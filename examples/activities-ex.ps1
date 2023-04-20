ipmo .\hpecom.psd1

# Create a new Com API client and acquire JWT
$cc = New-ComClient "<Your COM Client ID>" "<Your COM Client Secret>"

# Set the appropriate endpoint
$cc.Connection.endpoint="https://us-west2-api.compute.cloud.hpe.com"

# Get all activities where iLO auto firmware update failed
$cc.Activities.GetByField('key', 'SERVER_JOB_AUTO_ILO_FW_UPDATE_FAILED', '','')

# Get all activities where healthState is no OK and limit the results to the first 100
$q = [System.Collections.ArrayList]::New()
$q.add("healthState ne `'OK`'")
$cc.Activities.Get($q, '', 100)