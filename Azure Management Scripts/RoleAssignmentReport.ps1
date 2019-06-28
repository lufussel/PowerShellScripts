<#
.SYNOPSIS
    RoleAssignmentReport produces a CSV output of Azure role assignments across all accessible subscriptions

.DESCRIPTION
    RoleAssignmentReport allows you to:
    - Output all role assignments including Users and Service Principals
    - Output the location the role is assigned, whether at subscription, resource or resource group level
    
    This tool does not modify your configuration. As such, you can re-validate the configuration as many times as desired.

    Azure PowerShell (Az) must be installed, and an account must be authenticated with Connect-AzAccount.

.PARAMETER OutputPath
    Specifies the literal or relative paths to an output CSV file.
    The will be will overwritten each time the script is executed.
    This parameter is required.
#>


# Parameter definition

param (
    [Parameter(Mandatory=$True)]
    [string] $OutputPath
)


# Check output path is provided

If ($OutputPath -eq $null) { 
    Write-Error "Output path was not provided"
    break
}


# Create file if not exists, clear existing file

If ((Test-Path -Path $OutputPath) -eq $True) {
    Write-Host "Warning:"$OutputPath" will be overwritten" -ForegroundColor yellow
    $confirmation = Read-Host "Are you sure? (y/N)"
    if ($confirmation -ne 'y') {
        Write-Host "Exiting" -ForegroundColor yellow
        return
    }
    Clear-Content -Path $OutputPath
} 
else {
    New-Item -ItemType "file" -Path $OutputPath | Out-Null
}

Write-Host "The output file at $OutputPath will be used" -ForegroundColor yellow


# Get list of Azure subscriptions

$subscriptionList = Get-AzSubscription


# Cycle subscriptions, write role assignments to output path

ForEach ($subscription in $subscriptionList)
{
    Write-Host "Loading subscription:" $subscription.Id -ForegroundColor yellow
    Select-AzSubscription -Subscription $subscription.Id
    Write-Host "Writing role assignments to" $outputPath
    Get-AzRoleAssignment | Export-Csv -Path $outputPath -NoTypeInformation -Append
}

Write-Host "Role assignments written to" $outputPath -ForegroundColor green
