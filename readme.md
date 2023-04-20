# Powershell module for [HPE Greenlake for Compute Ops Management](https://www.hpe.com/us/en/hpe-greenlake-compute-ops-management.html) (COM)
This module is for interacting with the HPE Greenlake for Compute Ops Managment RESTful API.  This is not a standard Powershell module that exports cmdlets.  This module makes use of classes and their methods to interact with the API.  

## Getting Started
The first thing you must do is find your **Client ID** and **Client Secret** for logging into the COM application.

Go to the [HPE Greenlake Developer Portal](https://developer.greenlake.hpe.com/docs/greenlake/services/) services page for full instructions on generating API credentials.

You will not need to generate a token just obtain your Client ID and Client Secret.

## Limitations
As stated in the summary, this is not a traditional module containing functions or cmdlets that are exported to the user.  One of the drawbacks to this approach is that there is no inline help for methods of a class as there is for a cmdlet in a normal Powershell module.  In short, `Get-Help class.method` does not work.  

To see properties and methods for the classes.
1. Import the module path/to/hpecom.psd1
2. Create a new COM API Client
3. Pipe the COM API Client or child API clients to the Get-Member cmdlet

```Powershell
Import-Module c:\modules\hpecom.psd1
# Create a new API client connection and store the authentication token
$comClient = New-ComClient "<myClientID>" "<myClientSecret>"
$comClient | Get-Member

   TypeName: ComClient

Name           MemberType Definition
----           ---------- ----------
Equals         Method     bool Equals(System.Object obj)
GetHashCode    Method     int GetHashCode()
GetType        Method     type GetType()
ToString       Method     string ToString()
Activities     Property   Activities Activities {get;set;}
Connection     Property   Connection Connection {get;set;}
filters        Property   Filters filters {get;set;}
FwBundles      Property   FwBundles FwBundles {get;set;}
Groups         Property   Groups Groups {get;set;}
Jobs           Property   Jobs Jobs {get;set;}
JobTemplates   Property   JobTemplates JobTemplates {get;set;}
Reports        Property   Reports Reports {get;set;}
Schedules      Property   Schedules Schedules {get;set;}
Servers        Property   Servers Servers {get;set;}
ServerSettings Property   ServerSettings ServerSettings {get;set;}

$comClient.Servers | Get-Member

   TypeName: Servers

Name             MemberType Definition
----             ---------- ----------
Equals           Method     bool Equals(System.Object obj)
Get              Method     System.Object[] Get(string[] filter, string offset, string limit)
GetAlerts        Method     System.Object[] GetAlerts()
GetByField       Method     System.Object GetByField(string fieldName, string fieldValue, string offset, string limit)
GetById          Method     System.Object GetById(string resourceId)
GetByName        Method     System.Object GetByName(string name)
GetHashCode      Method     int GetHashCode()
GetNotifications Method     System.Object GetNotifications()
GetRawInventory  Method     System.Object GetRawInventory()
GetType          Method     type GetType()
ToString         Method     string ToString()
Connection       Property   Connection Connection {get;set;}
Data             Property   psobject Data {get;set;}
uri              Property   string uri {get;set;}
```

## Usage
Clone the repo to your local machine and execute `import-module path/to/hpecom.psd1` from a PowerShell prompt.

Refer to the resource examples in the `examples` directory for interacting with COM resource API clients.

## One last thing for now  
This is a work in progress.  Presently, mainly the `GET` functionality is implemented.
