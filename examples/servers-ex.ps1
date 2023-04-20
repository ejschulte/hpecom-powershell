#
ipmo .\hpecom.psd1

# Create a new Com API client and acquire JWT
$cc = New-ComClient "<Your COM Client ID>" "<Your COM Client Secret>"

# Set the appropriate endpoint
$cc.Connection.endpoint="https://us-west2-api.compute.cloud.hpe.com"

# Get a server object by name
$s = $cc.Servers.GetByName("HPE-HOL30")
$s.data

# Get a server object by id
$s = $cc.Servers.GetById("P43357-B21+K30APP0059")
$s.data

# Get a list of servers based on field name and value
$cc.Servers.GetByField("hardware/model", "ProLiant DL360 Gen11", '', '')

# Get a list of servers using a custom query
$q = [System.Collections.ArrayList]::New()
$q.add("hardware/model eq `'ProLiant DL325 Gen10 Plus`'")
$q.add("hardware/powerState eq `'ON`'")
$cc.Servers.Get($q, '', '')

# Server Power Operations
# All server power operations a dictionary representation of a job resource

# Power off a server gracefully
$s = $cc.Servers.GetByName("HPE-HOL07")         #Retrieve the server object
$s.PowerOff([PowerOffOption]::GracefulShutdown)

# Power on a server
$s = $cc.Servers.GetByName("HPE-HOL07")         #Retrieve the server object
$s.PowerOn()

# Restart a server
$s = $cc.Servers.GetByName("HPE-HOL07")         #Retrieve the server object
$s.Restart()

# Cold boot a server and monitor the resulting job
$s = $cc.Servers.GetByName("HPE-HOL07")         #Retrieve the server object
$bootJob = $s.ColdBoot()
$bootJob.Get()