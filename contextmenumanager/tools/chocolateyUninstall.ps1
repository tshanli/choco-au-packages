$ErrorActionPreference = 'Stop'

$packageName = 'contextmenumanager'
$softwareName = 'ContextMenuManager'
$installDir = Join-Path -Path $env:ChocolateyToolsLocation -ChildPath $packageName

$shortcutDir = [System.Environment]::GetFolderPath('Programs')
$shortcutPath = Join-Path -Path $shortcutDir -ChildPath ($softwareName + ".lnk")

Remove-Item -Path $shortcutPath -Force -ErrorAction SilentlyContinue
Remove-Item -Path $installDir -Recurse -Force -ErrorAction SilentlyContinue
