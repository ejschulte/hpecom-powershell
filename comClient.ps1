
# enum Method {
#     GET
#     PATCH
#     PUT
#     POST
#     DELETE
# }



# class RestClient {
#     [string]$Jwt = ""
#     [string]$Endpoint = ""
#     [user]$user
#     [password]

#     # hidden [string]login(
#     #     [string]$this.
#     # )

# }

Class ComClient{

    # Properties
    [Connection]$Connection
    [Servers]$Servers
    [Jobs]$Jobs
    [JobTemplates]$JobTemplates
    [Activities]$Activities
    [FwBundles]$FwBundles
    [Groups]$Groups
    [Reports]$Reports
    [Schedules]$Schedules
    [Filters]$Filters
    [ServerSettings]$ServerSettings

    #Constructors
    ComClient($id, $secret){
        $this.connection = [Connection]::New($id, $secret)
        $this.NewServersClient()
        $this.NewJobsClient()
        $this.NewJobTemplatesClient()
        $this.NewActivitiesClient()
        $this.NewFwBundlesClient()
        $this.NewGroupsClient()
        $this.NewReportsClient()
        $this.NewSchedulesClient()
        $this.NewFiltersClient()
        $this.NewServerSettingsClient()
    }

    #Methods
    hidden[void]NewServersClient(){
        $this.Servers = [Servers]::New()
        $this.Servers.Connection = $this.Connection
    }

    hidden[void]NewJobsClient(){
        $this.Jobs = [Jobs]::New()
        $this.Jobs.Connection = $this.Connection
    }

    hidden[void]NewJobTemplatesClient(){
        $this.JobTemplates = [JobTemplates]::New()
        $this.JobTemplates.Connection = $this.Connection
    }

    hidden[void]NewActivitiesClient(){
        $this.Activities = [Activities]::New()
        $this.Activities.Connection = $this.Connection
    }
    
    hidden[void]NewFwBundlesClient(){
        $this.FwBundles = [FwBundles]::New()
        $this.FwBundles.Connection = $this.Connection
    }

    hidden[void]NewGroupsClient(){
        $this.Groups = [Groups]::New()
        $this.Groups.Connection = $this.Connection
    }

    hidden[void]NewReportsClient(){
        $this.Reports = [Reports]::New()
        $this.Reports.Connection = $this.Connection
    }

    hidden[void]NewSchedulesClient(){
        $this.Schedules = [Schedules]::New()
        $this.Schedules.Connection = $this.Connection
    }

    hidden[void]NewFiltersClient(){
        $this.Filters = [Filters]::New()
        $this.Filters.Connection = $this.Connection
    }

    hidden[void]NewServerSettingsClient(){
        $this.ServerSettings = [ServerSettings]::New()
        $this.ServerSettings.Connection = $this.Connection
    }

        # SetQuery([array]$filters, [string]$offset, [string]$limit){
            
        #     if($filters.count -eq 1){
        #         $q = "filter"
        #         ForEach ($f in $filters){
        #             $q = "filter=$f"
        #         }
        #     }
        # }

        # [string]GetServers([string[]]$filters, [string]$offset, [string]$limit){
        #     $retval = Get-ComServers($filters, $offset, $limit)
        #     return $retval
        # }

}

# Function New-ComClient{
#     Param(
#         [Parameter(Mandatory=$True)]
#         [ValidateNotNullOrEmpty()]
#         [string]$id,

#         [Parameter(Mandatory=$True)]
#         [ValidateNotNullOrEmpty()]
#         [string]$secret
#     )

#     # $loginUrl = "https://sso.common.cloud.hpe.com/as/token.oauth2"
#     # Send-RestCall POST, $loginUrl
#     [ComClient]::New($id, $secret)
# }


