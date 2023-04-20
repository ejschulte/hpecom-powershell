<#

PS Module for HPE Compute Ops Manager

#>

$global:loginUrl = 'https://sso.common.cloud.hpe.com/as/token.oauth2'
$Global:CallStack = Get-PSCallStack
$verbose = ($Global:CallStack | ? { $_.Command -eq "<ScriptBlock>" }).position.text -match "-verbose"
$exTime = (Get-Date).Tofiletime()
$Global:Logfile = "$pwd\$exTime.hpecom.log"

Function New-ComClient{
    Param(
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string]$id,

        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string]$secret
    )

    [ComClient]::New($id, $secret)
}

Function Write-Log{
    
    [CmdletBinding()]
    Param ([string]$logString)

    $tStamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $logMessage =  "$tStamp $logString"
    add-content $Global:Logfile -value $logMessage

}