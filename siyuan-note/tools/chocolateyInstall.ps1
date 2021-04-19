Import-Module (ls $env:ChocolateyInstall\helpers\functions | % {$_.FullName})
Import-Module (ls $env:ChocolateyInstall\extensions\chocolatey-core | % {$_.FullName})

$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName = 'siyuan-note'
    fileType = 'exe'
    file64 = gi $toolsPath\*_x64.exe
    silentArgs = '/S'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
# ls $toolsPath\*.exe | % { rm $_ }

# $packageName = $packageArgs.packageName
# $installLocation = Get-AppInstallLocation $packageName
# if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
# Write-Host "$packageName installed to '$installLocation'"

# Register-Application "$installLocation\$packageName.exe"
# Write-Host "$packageName registered as $packageName"
