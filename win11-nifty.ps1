
Write-Output "installing apps via chocolatey"
Write-Output ""

# verify chocolatey is installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
  # chocolatey installs to C:\ProgramData\chocolatey
  # set install path for chocolatey tools; default C:/tools/
  [System.Environment]::SetEnvironmentVariable('ChocolateyToolsLocation','C:\ProgramData\ChocolateyTools', 'User')
  
  Write-Output "chocolatey not installed .. installing..."
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  
  Write-Output "chocolatey installed"
  Write-Output ""
}

# get apps to install in simple new line delimited text file
$apps = Get-Content -Path "choco-apps.txt"
   
# install apps
$nbr_installed = 0
$nbr_updated = 0
foreach ($app in $apps) {
  $app = $app.Trim()
  
  # skip blank new lines
  if ([string]::IsNullOrEmpty($app)) {
    continue
  }
  
  # skip comments
  if ($app.Substring(0, 1) -eq "#") {
    continue
  }
  
  Write-Output ""
  Write-Output "installing $app"
  try {
    $search = choco search $searchTerm --local-only
    if ($search -like "*already installed*") { 
      choco upgrade $app -y | Write-Output
      Write-Output "app already installed, updated $app"
      $nbr_updated++
    } else {
      choco install $app -y | Write-Output
      Write-Output "installed $app"
      $nbr_installed++
    }    
  } catch {
    Write-Host "error with app $app:"
    Write-Host $_  
  }
}

Write-Output ""
Write-Output "finished, installed $nbr_installed apps and updated $nbr_updated apps via chocolatey"
Write-Output ""
