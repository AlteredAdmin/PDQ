# Dell DCU Install History Scanner for PDQ

A PowerShell-based **PDQ Inventory scanner** that reads the Dell Command | Update `Activity.log` and returns the most recent successful Dell update installations, including drivers, BIOS, firmware, applications, and other Dell update types.

## Recommended repository name

```text
pdq-dell-dcu-install-history-scanner
```

## What it does

This scanner parses Dell Command | Update activity logs from:

```text
C:\ProgramData\Dell\UpdateService\Log\Activity.log
```

It looks for completed Dell update installation results and returns the latest successful entries as structured PowerShell objects that PDQ Inventory can collect and display.

By default, the scanner returns the **10 most recent successful installed updates**.

## Suggested PDQ scanner name

```text
Dell DCU Install History
```

## Suggested PDQ scan profile name

```text
Dell Command Update Audit
```

## Requirements

* Windows endpoint managed by PDQ Inventory
* Dell Command | Update installed on the target device
* Dell Command | Update activity log present at `C:\ProgramData\Dell\UpdateService\Log\Activity.log`
* PDQ scan account must be able to read the log file
