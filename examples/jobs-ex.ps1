ipmo .\hpecom.psd1

# Create a new Com API client and acquire JWT
$cc = New-ComClient "<Your COM Client ID>" "<Your COM Client Secret>"

# Set the appropriate endpoint
$cc.Connection.endpoint="https://us-west2-api.compute.cloud.hpe.com"

# Get the first 100 jobs
$cc.jobs.Get('',100)


# Create a new job to power off a server
[JobTemplates]::ComJobTemplates                     # Lists job templates and their IDs
$JtID = [JobTemplates]::ComJobTemplates.PowerOff    # Stores the PowerOff template id in a variable

$s = $cc.Servers.GetByName('HPE-HOL07')             # Retrieve the server resource
$sUri = $s.Data.resourceUri                         # Gets the server resource URI in a variable
# Build job data parameter if applicable
$jobData = @{
            operationType = "GracefulShutdown"
        }

$powerOffJob = $cc.Jobs.NewJob($jtID, $sUri, $jobData)  # Create the power off job (returns a job object)
$powerOffJob.Get()                                      # Monitor the jobs progress
$powerOffJob.Data.State                                 # Check the status
$s.data.hardware.powerState                             # Verify the server powerState

