$ErrorActionPreference = 'Stop'

$packageName = 'contextmenumanager'
$softwareName = 'ContextMenuManager'

$fileType = 'exe'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = Get-Item "$toolsDir\*.$fileType"

Move-Item -Path $embedded_path.FullName -Destination "$toolsDir\$softwareName.$fileType"

$embedded_path = Get-Item "$toolsDir\*.$fileType"
$programName = $embedded_path.Name

$installDir = Join-Path -Path (Get-ToolsLocation) -ChildPath $packageName
$destination = Join-Path -Path $installDir -ChildPath $programName

$shortcutsPath = Join-Path -Path ([System.Environment]::GetFolderPath('Programs')) -ChildPath ($softwareName + ".lnk")

if (!(Test-Path $installDir)) { mkdir $installDir -Force }
Move-Item -Path $embedded_path.FullName -Destination $destination -Force -Verbose
Install-ChocolateyShortcut -shortcutFilePath $shortcutsPath -targetPath $destination
