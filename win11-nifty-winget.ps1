# win11-winget-install.ps1
#
# install win11 programs using wget

# allow running powershell scripts 
# run as powershell admin; run other scripts as user
# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

# search winget by name
# winget search <application name>
# 
# export winget packages
# winget export --output winget-export.json
#
# import winget packages
# winget install --file winget-config.json
#
# upgrade all winget packages
# winget upgrade --all
#
# uninstall winget packages
# winget uninstall <application name or id>
#
# manually agree to winget license
# winget install --exact --id 7zip.7zip
# The `msstore` source requires that you view the following agreements before using.
# Terms of Transaction: https://aka.ms/microsoft-store-terms-of-transaction
#
# docs: https://learn.microsoft.com/en-us/windows/package-manager/winget/install
# winget ids of apps: https://winstall.app/apps

$timeStartScript = Get-Date

# options
$opts = @{
    # only output what would happen, don't actually copy anything
    dryrun = 0
    
    # json list of apps
    wingetConfigFile = "win11-apps-winget.json"
}

# functions
function PauseAndExit()
{
    try
    {
        # write-host "debug: "$host.Name
        if ($host.Name -eq "Windows PowerShell ISE Host")
        {
            $result = Read-Host "write-host "Press enter to continue...""
        }
        else
        {
            write-host "Press any key to continue..."
            [void][System.Console]::ReadKey($true)
        }
    }
    catch
    {
        # ide w/ redirect output
        write-host "exiting..."
    }
    exit
}
function RunWinget {
    param (
        [string]$action
    )
    $action = $action.Trim()
    if ($action -ne "install" -and $action -ne "upgrade" -and $action -ne "uninstall") {
        write-host "$action not expected 'install', 'upgrade', or 'uninstall'"
        exit
    }
    
    $wingetConfig = Get-Content -Path "$($opts.wingetConfigFile)" | ConvertFrom-JSON
    if (! ($wingetConfig | Get-Member -Name "installers")) {
        write-host "$($opts.wingetConfigFile) is missing key 'installers'"
        exit
    }
    $wingetApps = $wingetConfig.installers
    
    $qtySuccess = 0
    $qtyError = 0
    foreach ($wingetApp in $wingetApps) {
        if ($wingetApp | Get-Member -Name "_category") {
            $category = $wingetApp._category
        } else {
            $category = "no category"
        }
        if ($wingetApp | Get-Member -Name "_description") {
            $description = $wingetApp._description
        } else {
            $description = ""
        }
        if ($wingetApp | Get-Member -Name "packageIdentifier") {
            $id = $wingetApp.packageIdentifier
        } else {
            write-host "no packageIdentifier"
            write-host ($wingetApp | Format-List | Out-String)
            continue
        }
        if ($wingetApp | Get-Member -Name "arguments") {
            $arguments = $wingetApp.arguments
        } else {
            $arguments = ""
        }

      
      $wingetCmdArgs = ""
      $wingetCmdArgs += "$action "
      $wingetCmdArgs += "--exact --id "
      $wingetCmdArgs += "$id "
      if ($arguments -ne "") {
        $wingetCmdArgs += "$arguments "
      }

      write-host "$category : winget $wingetCmdArgs : " -NoNewLine
      if ($description -ne "") {
        write-host "  $description"
      }
      
      if ($category.StartsWith("#") -or $id.StartsWith("#")) {
        write-host "Skip"
        continue
      }     
      if ($opts.dryrun) {
          write-host "Dryrun"
          continue
      }
      # & "winget" $wingetCmdArgs
      $process = Start-Process -Wait -PassThru "winget" -ArgumentList "$wingetCmdArgs" | Out-Null
      if ($process.ExitCode -le 0) {
            write-host "Success"
            $qtySuccess++
        } else {
            write-host "Error"
            $qtyError++
        }
    }
    write-host "winget $action $qtySuccess packages"
    if ($qtyError -gt 0) {
        write-host "$action $qtyError package errors"
    }
}

# validate options
if ($opts.dryrun -ne 0 -and $opts.dryrun -ne 1)
{
    write-host "Stopped"
    write-host "Edit dryrun variable and read script"
    PauseAndExit
}
if (! (Test-Path $opts.wingetConfigFile -PathType Leaf))
{
    write-host "Stopped"
    write-host "Edit wingetConfigFile '$($opts.wingetConfigFile)' variable and read script"
    PauseAndExit
}

#
# start
#


RunWinget("install")

# RunWinget("upgrade")

# RunWinget("uninstall")

# finish
$timeFinishScript = Get-Date
$timeElapsedScript = $timeFinishScript - $timeStartScript

write-host ""
$runtime = $timeElapsedScript.ToString("hh\:mm\:ss")
if ($opts.dryrun)
{
    write-host "dryrun: " -NoNewLine
}
write-host "winget finished in $runtime"

write-host ""
PauseAndExit
