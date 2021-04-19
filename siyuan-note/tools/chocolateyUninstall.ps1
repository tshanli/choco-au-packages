$ErrorActionPreference = 'Stop'
$version = '1.1.83'
$softwareName = 'SiYuan'
$packageArgs = @{
    packageName = 'siyuan-note'
    fileType = 'exe'
    validExitCodes = @(0)
}
(Get-UninstallRegistryKey -SoftwareName "$softwareName $version").UninstallString -match "(?<file>`".*`.exe`") (?<args>.*)" > $null
$packageArgs.file = $Matches.file
$packageArgs.silentArgs = "/S $($Matches.args)"
Uninstall-ChocolateyPackage @packageArgs
