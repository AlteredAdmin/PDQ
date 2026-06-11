# Dell DCU Install History Scanner

A PowerShell-based **PDQ Inventory scanner** that reads the Dell Command | Update `Activity.log` and returns the most recent successful Dell update installations, including drivers, BIOS, firmware, applications, and other Dell update types.

## What it does

This scanner parses Dell Command | Update activity logs from:

```text
C:\ProgramData\Dell\UpdateService\Log\Activity.log
```

It looks for completed Dell update installation results and returns the latest successful entries as structured PowerShell objects that PDQ Inventory can collect and display.

By default, the scanner returns the **10 most recent successful installed updates**.

## Requirements

* Windows endpoint managed by PDQ Inventory
* Dell Command | Update installed on the target device
* Dell Command | Update activity log present at `C:\ProgramData\Dell\UpdateService\Log\Activity.log`
* PDQ scan account must be able to read the log file
