# win11-nifty
Nifty way to install apps in Win11 using [chocolatey](https://community.chocolatey.org/)

[chocolatey]([https://scoop-docs.now.sh/](https://docs.chocolatey.org/en-us/choco/setup)) is a command-line installer for Windows, which allows you to script an install, update, modification, etc of your Windows 11.
There is also a GUI avaialbe, [Chocolatey GUI](https://docs.chocolatey.org/en-us/chocolatey-gui/)

features  
========
* Scripted chocolatey (choco) commands for easy installs
* Scripted configuration
* Checks for existing installed apps

usage
========
* Download this repo  
* Review and modify scripts  
* Open win11-nifty.ps1 in Powershell ISE or Powershell, then run  
-or-
* Right click on win11-nifty.ps1  
Run as Administrator  
-or-   
Run with Powershell  

Note: if you get an error you might need to change the execution policy (i.e. enable Powershell) with  
`> Set-ExecutionPolicy RemoteSigned -scope CurrentUser`

  
scripts
=========
* win11-nifty.ps1  
  main script; run this
  

screenshots
========
(none yet)

change log
========
2023-04-20 version 0.0.1
* initial version
* split install apps into own scripts


license
========
https://opensource.org/licenses/MIT
