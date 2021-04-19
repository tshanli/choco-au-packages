import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'https://github.com/siyuan-note/siyuan/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyUninstall.ps1" = @{
            "(?i)(^\s*[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
        }

        "$($Latest.PackageName).nuspec"   = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt"        = @{
            "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
            "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
            "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }
function global:au_AfterUpdate { Set-DescriptionFromReadme }

function global:au_GetLatest {
    # $software_name = $releases -split '/' | select -Last 1 -Skip 1

    $download_page = Invoke-WebRequest -Uri $releases

    $re64 = "siyuan-1.1.83-win.exe"
    $url = $download_page.links | ? href -match $re64 | select -expand href -First 1
    $url = 'https://github.com' + $url

    $version = ($url -split '/' | select -Last 1 -Skip 1) -replace "^[v](.*)","`$1"

    return @{
        URL64        = $url
        Version      = $version
        ReleaseNotes = "$releases/tag/${version}"
    }
}

update -ChecksumFor none -NoCheckChocoVersion
