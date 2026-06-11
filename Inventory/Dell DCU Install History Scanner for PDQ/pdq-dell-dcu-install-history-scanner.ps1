$LatestEntryCount = 10
$LogPath = 'C:\ProgramData\Dell\UpdateService\Log\Activity.log'

# Use @('DRVR') for drivers only.
# Use @() to include all update types: DRVR, BIOS, FRMW, APAC, etc.
$UpdateTypesToInclude = @()

function New-Result {
    param(
        [string]$InstalledOn,
        [string]$UpdateName,
        [string]$UpdateType,
        [string]$Version,
        [string]$Category,
        [string]$ReleaseID,
        [string]$Status,
        [string]$ExitCode,
        [string]$Reboot,
        [string]$Source,
        [string]$LogPath
    )

    [PSCustomObject]@{
        InstalledOn = $InstalledOn
        UpdateName  = $UpdateName
        UpdateType  = $UpdateType
        Version     = $Version
        Category    = $Category
        ReleaseID   = $ReleaseID
        Status      = $Status
        ExitCode    = $ExitCode
        Reboot      = $Reboot
        Source      = $Source
        LogPath     = $LogPath
    }
}

function Get-ChildText {
    param(
        [xml.xmlnode]$Node,
        [string]$Name
    )

    if (-not $Node) {
        return ''
    }

    $child = $Node.ChildNodes |
        Where-Object { $_.NodeType -eq 'Element' -and $_.LocalName -ieq $Name } |
        Select-Object -First 1

    if ($child) {
        return (($child.InnerText -replace '\s+', ' ').Trim())
    }

    return ''
}

if (-not (Test-Path -LiteralPath $LogPath)) {
    New-Result `
        -InstalledOn '' `
        -UpdateName '' `
        -UpdateType '' `
        -Version '' `
        -Category '' `
        -ReleaseID '' `
        -Status 'No Dell Command Update Activity.log found' `
        -ExitCode '' `
        -Reboot '' `
        -Source '' `
        -LogPath $LogPath
    return
}

try {
    [xml]$Xml = Get-Content -LiteralPath $LogPath -Raw -ErrorAction Stop
}
catch {
    New-Result `
        -InstalledOn '' `
        -UpdateName '' `
        -UpdateType '' `
        -Version '' `
        -Category '' `
        -ReleaseID '' `
        -Status "Could not read Activity.log: $($_.Exception.Message)" `
        -ExitCode '' `
        -Reboot '' `
        -Source '' `
        -LogPath $LogPath
    return
}

$Entries = foreach ($node in $Xml.SelectNodes('//LogEntry')) {
    $timestamp = Get-ChildText -Node $node -Name 'timestamp'
    $source    = Get-ChildText -Node $node -Name 'source'
    $message   = Get-ChildText -Node $node -Name 'message'

    # In the sample log, completed install results are logged here.
    if ($source -notmatch 'Update\.Operations\.UpdateOperation\.LogExecutionStatus') {
        continue
    }

    $dataNode = $node.ChildNodes |
        Where-Object { $_.NodeType -eq 'Element' -and $_.LocalName -ieq 'data' } |
        Select-Object -First 1

    if (-not $dataNode) {
        continue
    }

    $type       = Get-ChildText -Node $dataNode -Name 'Type'
    $releaseID  = Get-ChildText -Node $dataNode -Name 'ReleaseID'
    $name       = Get-ChildText -Node $dataNode -Name 'Name'
    $version    = Get-ChildText -Node $dataNode -Name 'VendorVersion'
    $updateType = Get-ChildText -Node $dataNode -Name 'UpdateType'
    $category   = Get-ChildText -Node $dataNode -Name 'Category'
    $reboot     = Get-ChildText -Node $dataNode -Name 'Reboot'
    $exitCode   = Get-ChildText -Node $dataNode -Name 'ExitCode'
    $status     = Get-ChildText -Node $dataNode -Name 'Status'

    # Keep only successful install result entries.
    if ($type -ine 'Install') {
        continue
    }

    if ($status -ine 'Success') {
        continue
    }

    # Optional filter. If $UpdateTypesToInclude is empty, include all update types.
    if ($UpdateTypesToInclude.Count -gt 0 -and $UpdateTypesToInclude -notcontains $updateType) {
        continue
    }

    if ([string]::IsNullOrWhiteSpace($name)) {
        $name = $message
    }

    New-Result `
        -InstalledOn $timestamp `
        -UpdateName $name `
        -UpdateType $updateType `
        -Version $version `
        -Category $category `
        -ReleaseID $releaseID `
        -Status $status `
        -ExitCode $exitCode `
        -Reboot $reboot `
        -Source $source `
        -LogPath $LogPath
}

$Entries = $Entries |
    Sort-Object {
        try { [datetimeoffset]$_.InstalledOn } catch { [datetimeoffset]::MinValue }
    } -Descending |
    Select-Object -First $LatestEntryCount

if ($Entries) {
    $Entries
}
else {
    New-Result `
        -InstalledOn '' `
        -UpdateName '' `
        -UpdateType ($UpdateTypesToInclude -join ',') `
        -Version '' `
        -Category '' `
        -ReleaseID '' `
        -Status 'No successful installed update entries found in Dell Command Update log' `
        -ExitCode '' `
        -Reboot '' `
        -Source '' `
        -LogPath $LogPath
}
