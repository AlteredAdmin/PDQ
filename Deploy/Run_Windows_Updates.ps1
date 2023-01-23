####################################################################
$text = @"

_______        _______ _______  ______ _______ ______       _______ ______  _______ _____ __   _
|_____| |         |    |______ |_____/ |______ |     \      |_____| |     \ |  |  |   |   | \  |
|     | |_____    |    |______ |    \_ |______ |_____/      |     | |_____/ |  |  | __|__ |  \_|
                                                                                                

Title: Run Windows Updates
Description: 
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
    Title: Run Windows Updates
    OS Support: 
    Required modules: NONE

.DESCRIPTION
     used to search, download, and install software updates on a Windows system. The script starts by creating a search query that looks for updates 
     that are not currently installed, are of the "Software" type, and are not hidden. This search query is then passed to a Microsoft.Update.Session 
     object, which is used to create an UpdateSearcher object. This UpdateSearcher object is used to search for updates based on the search query, 
     and the results are stored in the $SearchResults variable. The script then uses the UpdateSearcher object to download the updates found in the 
     search results and then uses an UpdateInstaller object to install the downloaded updates.


.EXAMPLE
    

.NOTES
    Author:         Altered Admin
    Email:          
    Date:           Jan 13 2023
#>

Write-Host $text

####################################################################

$searchQuery = "IsInstalled=0 and Type='Software' and IsHidden=0"

$Session = New-Object -ComObject Microsoft.Update.Session
$Search = $Session.CreateUpdateSearcher() 
$SearchResults = $Search.Search($searchQuery)



$SearchResults.Updates


$downloader = $Session.CreateUpdateDownloader()
$downloader.Updates = $SearchResults.Updates
$downloader.Download()


$Installer = $Session.CreateUpdateInstaller()
$Installer.Updates = $SearchResults.Updates
$Installer.Install()