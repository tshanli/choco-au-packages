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
ls $toolsPath\*.exe | % { rm $_ }
