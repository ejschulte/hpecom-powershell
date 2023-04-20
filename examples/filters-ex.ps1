# Create a new Com API client and acquire JWT
$cc = New-ComClient "<Your COM Client ID>" "<Your COM Client Secret>"

# Set the appropriate endpoint
$cc.Connection.endpoint="https://us-west2-api.compute.cloud.hpe.com"

# Get all saved search filters
$cc.filters.Get('', '', '')

# Get a filter by name and output the filter data
$myFilter = $cc.filters.GetByName('<name>')
$myFilter.data

