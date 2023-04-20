# Create a new Com API client and acquire JWT
$cc = New-ComClient "<Your COM Client ID>" "<Your COM Client Secret>"

# Set the appropriate endpoint
$cc.Connection.endpoint="https://us-west2-api.compute.cloud.hpe.com"

# Get all server groups
$cc.groups.get('','','')

# Get the server group named Marketing and output the group data
$mktgroup = $cc.groups.GetByName('Marketing')
$mktgroup.data

# Get the devices in the Marketing server group
$mktgroup = $cc.groups.GetByName('Marketing')
$mktgroup.GetDevices()

# Get the devices and their compliance in the marketing group
$mktgroup = $cc.groups.GetByName('Marketing')
$mktgroup.GetDevicesCompliance()