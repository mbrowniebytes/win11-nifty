# win11-nifty
Nifty way to install apps in Windows 11 using 
[chocolatey](https://community.chocolatey.org/) or 
[winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/)

chocolatey is a command-line installer for Windows, which allows you to script an install, update, modification, etc of your Windows 11.
There is also a GUI avaialbe, [Chocolatey GUI](https://docs.chocolatey.org/en-us/chocolatey-gui/)

winget is a command line tool enabling users to discover, install, upgrade, remove and configure applications on Windows.
There is also a GUI avaialbe, [UnigetUI](https://github.com/marticliment/UnigetUI)

features  
========
* Scripted chocolatey (choco) commands for easy installs
* Scripted winget (winget) commands for easy installs
* Scripted configuration
* Checks for existing installed apps

usage
========
* Download this repo  
* Review and modify scripts  
* Open win11-nifty-*.ps1 in Powershell ISE or Powershell, then run  
-or-
* Right click on win11-nifty-*.ps1  
Run as Administrator  
-or-   
Run with Powershell  

Note: if you get an error you might need to change the execution policy (i.e. enable Powershell) with  
`> Set-ExecutionPolicy RemoteSigned -scope CurrentUser`

  
scripts
=========
* win11-nifty-choco.ps1
* win11-nifty-winget.ps1  
  

screenshots
========
(none yet)

change log
========
2025-10-26 version 0.0.2  
* add winget

2023-04-20 version 0.0.1  
* initial version
* split install apps into own scripts


license
========
https://opensource.org/licenses/MIT
