###########################################################
#  By Proliantaholic https://proliantaholic.blogspot.com  #
###########################################################

param (
    [string]$ScriptsPath = ".",
    [string]$BrowserType = "Chrome",
    [string]$VerChrome = "Detect",
    [string]$VerEdge = "Detect"
)

[Console]::OutputEncoding = [Text.Encoding]::UTF8

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$global:ProgressPreference = 'SilentlyContinue'

if (!(Test-Path -Path $ScriptsPath\ObsData\)) {
    mkdir $ScriptsPath\ObsData\ > $null 2>&1
}

$DriverList = @{ 'Chrome' = 'chromedriver'; 'Edge' = 'msedgedriver'; 'Firefox' = 'geckodriver' }
$DriverVersionPattern = "(?<=[d|D]river.)\d+(\.\d+)+ "
if ($DriverExists = Test-Path -Path "$ScriptsPath\ObsData\$($DriverList[$BrowserType]).exe") {
    $DriverVersion = & $ScriptsPath\ObsData\$($DriverList[$BrowserType]).exe -V
    $DriverVersion = [regex]::Match($DriverVersion, $DriverVersionPattern).captures.groups[0].value
}

$SeleniumDLLExists = Test-Path -Path $ScriptsPath\ObsData\WebDriver.dll

switch ($BrowserType) {
    "Chrome" {
        $ErrorActionPreference = "Stop"
        try {
            $VerDetect = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo.ProductVersion
            $VerDetect = $VerDetect -replace '^(.+?)\..*$', '$1'
            if ($VerChrome -eq "Detect") { $VerMajor = $VerDetect }
            $BrowserExists = $True
        }
        catch {
            Write-Host "ChromeNotFound"
            Exit
        }
        $ErrorActionPreference = "Continue"
        Break
    }
    "Edge" {
        $ErrorActionPreference = "Stop"
        try {
            $VerDetect = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe').'(Default)').VersionInfo.ProductVersion
            $VerDetect = $VerDetect -replace '^(.+?)\..*$', '$1'
            if ($VerEdge -eq "Detect") { $VerMajor = $VerDetect }
            $BrowserExists = $True
        }
        catch {
            Write-Host "EdgeNotFound"
            Exit
        }
        $ErrorActionPreference = "Continue"
        Break
    }
    "Firefox" {
        $ErrorActionPreference = "Stop"
        try {
            $VerFirefox = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe').'(Default)').VersionInfo.ProductVersion
            $VerMajor = $VerFirefox -replace '^(.+?)\..*$', '$1'
            $BrowserExists = $True
        }
        catch {
            Write-Host "FirefoxNotFound"
            Exit
        }
        $ErrorActionPreference = "Continue"
        Break
    }
    default {
        # 不支援的瀏覽器
        Write-Host "BrowserNotFound"
        Exit
    }
}

if (!(Test-Connection 8.8.8.8 -Quiet) 2>$null) {
    # 網路連線異常
    if ($BrowserExists -and $DriverExists -and $SeleniumDLLExists) {
        Write-Host "Skip"
    }
    else {
        Write-Host "Stop"
    }
    Exit
}

switch ($BrowserType) {
    "Chrome" {
        # Chrome WebDriver
        $ChromeURL = "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$VerMajor"
        if ($DriverExists) {
            $DownVer = (Invoke-WebRequest -UseBasicParsing -Uri $ChromeURL).Content
            if ([System.Version]$DownVer -gt [System.Version]$DriverVersion) {
                $Download = $True
                Remove-Item "$ScriptsPath\ObsData\$($DriverList[$BrowserType]).exe" -Force
            }
            else {
                $Download = $False
            }
        }
        else {
            $Download = $True
        }
        if ($Download) {
            if (!$DriverExists) {
                $DownVer = (Invoke-WebRequest -UseBasicParsing -Uri $ChromeURL).Content
            }
            $DownURL = "https://chromedriver.storage.googleapis.com/$DownVer/chromedriver_win32.zip"
            $ChromeFile = "chromedriver_win32_$DownVer.zip"
            (New-Object -TypeName System.Net.WebClient).DownloadFile($DownURL, "$ScriptsPath\$ChromeFile")
            Expand-Archive "$ScriptsPath\$ChromeFile" "$ScriptsPath\WebDriverTemp" -Force
            Move-Item "$ScriptsPath\WebDriverTemp\chromedriver.exe" "$ScriptsPath\ObsData" -Force
            Remove-Item "$ScriptsPath\$ChromeFile" -Force
            Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
        }
        Break
    }
    "Edge" {
        # Microsoft Edge (Chromium) WebDriver
        $EdgeURL = "https://msedgedriver.azureedge.net/LATEST_RELEASE_$($VerMajor)_WINDOWS"
        if ($DriverExists) {
            $VerString = [System.Text.Encoding]::Unicode.GetString((Invoke-WebRequest -UseBasicParsing -Uri $EdgeURL).Content)
            $DownVer = $VerString.substring(1, ($VerString.length - 3))
            if ([System.Version]$DownVer -gt [System.Version]$DriverVersion) {
                $Download = $True
                Remove-Item "$ScriptsPath\ObsData\$($DriverList[$BrowserType]).exe" -Force
            }
            else {
                $Download = $False
            }
        }
        else {
            $Download = $True
        }
        if ($Download) {
            if (!$DriverExists) {
                $data = [System.Text.Encoding]::Unicode.GetString((Invoke-WebRequest -UseBasicParsing -Uri $EdgeURL).Content)
                $DownVer = $data.substring(1, ($data.length - 3))
            }
            if ([System.Environment]::Is64BitOperatingSystem) {
                $DownURL = "https://msedgedriver.azureedge.net/$($DownVer)/edgedriver_win64.zip"
                $EdgeFile = "edgedriver_win64_$DownVer.zip"
            }
            else {
                $DownURL = "https://msedgedriver.azureedge.net/$($DownVer)/edgedriver_win32.zip"
                $EdgeFile = "edgedriver_win32_$DownVer.zip"
            }
            (New-Object -TypeName System.Net.WebClient).DownloadFile($DownURL, "$ScriptsPath\$EdgeFile")
            Expand-Archive "$ScriptsPath\$EdgeFile" "$ScriptsPath\WebDriverTemp" -Force
            Move-Item "$ScriptsPath\WebDriverTemp\msedgedriver.exe" "$ScriptsPath\ObsData" -Force
            Remove-Item "$ScriptsPath\$EdgeFile" -Force
            Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
        }
        Break
    }
    "Firefox" {
        # Firefox WebDriver
        $FirefoxURL = "https://api.github.com/repos/mozilla/geckodriver/releases"
        if ($DriverExists) {
            $data = Invoke-WebRequest -UseBasicParsing -Uri $FirefoxURL | ConvertFrom-Json
            if ([System.Environment]::Is64BitOperatingSystem) {
                for ($index = 0; $index -lt $data[0].assets.Length; $index++) {
                    if ($data[0].assets[$index].name -match '(geckodriver-.*-win64\.zip)$') {
                        $FirefoxFile = $data[0].assets[$index].name
                        $DownURL = $data[0].assets[$index].browser_download_url
                        $DownVer = $data[0].name
                        break
                    }
                }
            }
            else {
                for ($index = 0; $index -lt $data[0].assets.Length; $index++) {
                    if ($data[0].assets[$index].name -match '(geckodriver-.*-win32\.zip)$') {
                        $FirefoxFile = $data[0].assets[$index].name
                        $DownURL = $data[0].assets[$index].browser_download_url
                        $DownVer = $data[0].name
                        break
                    }
                }
            }
            if ([System.Version]$DownVer -gt [System.Version]$DriverVersion) {
                $Download = $True
                Remove-Item "$ScriptsPath\ObsData\$($DriverList[$BrowserType]).exe" -Force
            }
            else {
                $Download = $False
            }
        }
        else {
            $Download = $True
        }
        if ($Download) {
            if (!$DriverExists) {
                $data = Invoke-WebRequest -UseBasicParsing -Uri $FirefoxURL | ConvertFrom-Json
                if ([System.Environment]::Is64BitOperatingSystem) {
                    for ($index = 0; $index -lt $data[0].assets.Length; $index++) {
                        if ($data[0].assets[$index].name -match '(geckodriver-.*-win64\.zip)$') {
                            $FirefoxFile = $data[0].assets[$index].name
                            $DownURL = $data[0].assets[$index].browser_download_url
                            $DownVer = $data[0].name
                            break
                        }
                    }
                }
                else {
                    for ($index = 0; $index -lt $data[0].assets.Length; $index++) {
                        if ($data[0].assets[$index].name -match '(geckodriver-.*-win32\.zip)$') {
                            $FirefoxFile = $data[0].assets[$index].name
                            $DownURL = $data[0].assets[$index].browser_download_url
                            $DownVer = $data[0].name
                            break
                        }
                    }
                }
            }
            (New-Object -TypeName System.Net.WebClient).DownloadFile($DownURL, "$ScriptsPath\$FirefoxFile")
            Expand-Archive "$ScriptsPath\$FirefoxFile" "$ScriptsPath\WebDriverTemp" -Force
            Move-Item "$ScriptsPath\WebDriverTemp\geckodriver.exe" "$ScriptsPath\ObsData" -Force
            Remove-Item "$ScriptsPath\$FirefoxFile" -Force
            Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
        }
        Break
    }
}

# Selenium
$SeleniumURL = "https://www.nuget.org/packages/Selenium.WebDriver"
if ($SeleniumDLLExists) {
    $data = (Invoke-WebRequest -UseBasicParsing -Uri $SeleniumURL).ToString()
    $DownVer = [regex]::Match($data, '.*<a href="/packages/Selenium.WebDriver.*title="(.*)"').captures.groups[1].value
    $DownVerDate = [datetime][regex]::Match($data, '(?<=<span data-datetime=").+(?=T.*">)').value
    $DriverVersionDate = [datetime](Get-Item "$ScriptsPath\ObsData\WebDriver.dll").LastWriteTime
    if (($DownVerDate - $DriverVersionDate).Days -gt 7) {
        $Download = $True
        Remove-Item "$ScriptsPath\ObsData\WebDriver.dll" -Force
    }
    else {
        $Download = $False
    }
}
else {
    $Download = $True
}
if ($Download) {
    if (!$SeleniumDLLExists) {
        $data = (Invoke-WebRequest -UseBasicParsing -Uri $SeleniumURL).ToString()
        $DownVer = [regex]::Match($data, '.*<a href="/packages/Selenium.WebDriver.*title="(.*)"').captures.groups[1].value
    }
    # $DownVer = "4.0.0-beta2"   # 下載特定版本: comment $data, $DownVer
    $DownURL = "https://www.nuget.org/api/v2/package/Selenium.WebDriver/" + $DownVer
    $SeleniumFile = "selenium.webdriver.$DownVer.nupkg"
    (New-Object -TypeName System.Net.WebClient).DownloadFile($DownURL, "$ScriptsPath\$SeleniumFile")
    Rename-Item "$ScriptsPath\$SeleniumFile" "$ScriptsPath\$SeleniumFile.zip"
    Expand-Archive "$ScriptsPath\$SeleniumFile.zip" "$ScriptsPath\WebDriverTemp" -Force
    Move-Item "$ScriptsPath\WebDriverTemp\lib\net48\WebDriver.dll" "$ScriptsPath\ObsData" -Force
    Remove-Item "$ScriptsPath\$SeleniumFile.zip" -Force
    Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
}
$global:ProgressPreference = 'Continue'

Write-Host "Kick"
