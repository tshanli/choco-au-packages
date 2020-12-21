import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases    = 'https://github.com/BluePointLilac/ContextMenuManager/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*[$]fileType\s*=\s*)('.*')"   = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }
function global:au_AfterUpdate  { Set-DescriptionFromReadme }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re  = "ContextMenuManager.NET.4.exe"
    $url = $download_page.links | ? href -match $re | select -expand href
    $url = 'https://github.com' + $url
    echo $url

    $version = $url -split '/' | select -Last 1 -Skip 1
    echo $url

    return @{
        URL32        = $url
        Version      = $version
        ReleaseNotes = "$releases/tag/${version}"
    }
}

update -ChecksumFor none
