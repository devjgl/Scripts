Function Set-Wallpaper {
    Param (
        [string] $ImgPath
    )
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name wallpaper -Value $ImgPath
    rundll32.exe user32.dll, UpdatePerUserSystemParameters 1, True
}

[string]$file = "potd$(Get-Date -Format "ddMMyyyy").jpg"
[string]$saveLocation = "$home\Documents\potd"

# Create directory
New-Item -ItemType Directory -Path $saveLocation 2>&1 | Out-Null

# Get Picture of the Day
Invoke-RestMethod "bing.com$((Invoke-RestMethod -Method GET -Uri "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=nl-NL").images.url)" -OutFile "$saveLocation\$file"

# Set wallpaper
Set-Wallpaper -ImgPath "$saveLocation\$file"