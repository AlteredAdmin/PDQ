####################################################################
$text = @"

_______        _______ _______  ______ _______ ______       _______ ______  _______ _____ __   _
|_____| |         |    |______ |_____/ |______ |     \      |_____| |     \ |  |  |   |   | \  |
|     | |_____    |    |______ |    \_ |______ |_____/      |     | |_____/ |  |  | __|__ |  \_|
                                                                                                

Title: Active or Passive node in Fail over Cluster
Description: Used as a scanner for PDQ inventory
More info: https://alteredadmin.github.io/
=====================================================
Name: Altered Admin
Website: https://alteredadmin.github.io
Twitter: https://twitter.com/Alt3r3dAdm1n
If you found this helpful Please consider:
Buymeacoffee: http://buymeacoffee.com/alteredadmin
BTC: bc1qhkw7kv9dtdk8xwvetreya2evjqtxn06cghyxt7
LTC: ltc1q2mrh9s8sgmh8h5jtra3gqxuhvy04vuagpm3dk9
ETH: 0xef053b0d936746Df00C9CCe0454b7b8afb1497ac

"@

####################################################################

<#
.SYNOPSIS
    Title: Active or Passive node in Fail over Cluster
    OS Support: 
    Required modules: NONE

.DESCRIPTION
    This is a PowerShell command that compares the hostname of the machine with the name of the node that owns a specific resource in a Failover Cluster.
    The hostname of the machine is obtained by using the "hostname" command.
    The name of the node that owns the resource "SQL Server" is obtained by using the "Get-ClusterResource" cmdlet with the "-Name" parameter set to 
    "SQL Server", and then accessing the "OwnerNode.Name" property.
    The "hostname" and the "OwnerNode.Name" are compared using the "-eq" operator, which tests for equality.
    This command will return true if the hostname of the machine matches the name of the node that owns the "SQL Server" resource in the Failover Cluster, 
    otherwise it will return false.


.EXAMPLE
    

.NOTES
    Author:         Altered Admin
    Email:          
    Date:           Jan 13 2023
#>

Write-Host $text

####################################################################


(hostname) -eq (Get-ClusterResource -Name "SQL Server").OwnerNode.Name
