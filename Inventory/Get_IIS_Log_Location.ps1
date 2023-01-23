####################################################################
$text = @"

_______        _______ _______  ______ _______ ______       _______ ______  _______ _____ __   _
|_____| |         |    |______ |_____/ |______ |     \      |_____| |     \ |  |  |   |   | \  |
|     | |_____    |    |______ |    \_ |______ |_____/      |     | |_____/ |  |  | __|__ |  \_|
                                                                                                

Title: Get IIS log Location
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
    Title: Get IIS log Location
    OS Support: 
    Required modules: NONE

.DESCRIPTION
    Retrieves information about all websites on the machine using the "Get-Website" cmdlet.
    For each website, it selects the directory of the log file using the "ForEach" loop and the $_.LogFile.Directory property.
    Finally, it sorts the directories and only shows unique directories using the "Sort-Object -Unique" cmdlet.
    This command will list the unique directories where all the websites on the machine are storing their log files.


.EXAMPLE
    

.NOTES
    Author:         Altered Admin
    Email:          
    Date:           Jan 13 2023
#>

Write-Host $text

####################################################################


((Get-Website) | ForEach { $_.LogFile.Directory }) | Sort-Object -Unique

