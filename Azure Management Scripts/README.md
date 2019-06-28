# Role Assignment Report

## About
RoleAssignmentsReport produces a CSV output of Azure role assignments across all accessible subscriptions

## Description 

Role Assignment Report allows you to:
- Output all role assignments including Users and Service Principals
- Output the location the role is assigned, whether at subscription, resource or resource group level

This tool does not modify your configuration. As such, you can re-validate the configuration as many times as desired.

Azure PowerShell (Az) must be installed, and an account must be authenticated with Connect-AzAccount.

## Parameters

### -OutputPath

Specifies the literal or relative paths to an output CSV file.

The will be will overwritten each time the script is executed.

This parameter is required.