if (-not (Get-Command choco.exe)) {
    # Install Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Set Chocolatey Alias
Set-Alias -Name choco -Value (Get-Command choco.exe).Source

function Install-ChocolateyPackage {
    param (
        [Parameter(Mandatory = $true)]
        [string] $PackageName,
        [string] $Version
    )

    Write-Host "Installing package $PackageName@$(-not $Version ? 'latest' : $Version)"
    if (-not $Version) {
        choco upgrade $PackageName --yes
    }
    else {
        choco upgrade $PackageName --version $Version --yes
    }
}

if (-not (choco list speedtest --local-only | Select-String "speedtest" | Measure-Object).Count -eq 1) {
    Install-ChocolateyPackage -PackageName speedtest
}

speedtest