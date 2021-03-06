###########################################################
#  By Proliantaholic https://proliantaholic.blogspot.com  #
###########################################################

param (
    [string]$ScriptsPath = ".",
    [string]$BrowserType = "Chrome",
    [string]$VerChrome = "Detect",
    [string]$VerEdge = "Detect"
)

[Console]::OutputEncoding=[Text.Encoding]::UTF8

if (!(Test-Path -Path $ScriptsPath\ObsData\)) {
    mkdir $ScriptsPath\ObsData\ >$null 2>&1
}

switch ($BrowserType)
{
    "Chrome"  {
                  $ErrorActionPreference = "Stop"
                  try {
                          $VerDetect = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo.ProductVersion
                          $VerDetect = $VerDetect -replace '^(.+?)\..*$','$1'
                          if ($VerChrome -eq "Detect") { $VerChrome = $VerDetect }
                          $ChromeExists = $True
                      }
                  catch {
                          $ChromeExists = $False
                          Write-Host "ChromeNotFound"
                          Exit
                        }
                  $ErrorActionPreference = "Continue"
                  $ChromeDrvExists = Test-Path -Path $ScriptsPath\ObsData\chromedriver.exe
                  Break
              }
    "Edge"    {
                  $ErrorActionPreference = "Stop"
                  try {
                          $VerDetect = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe').'(Default)').VersionInfo.ProductVersion
                          $VerDetect = $VerDetect -replace '^(.+?)\..*$','$1'
                          if ($VerEdge -eq "Detect") { $VerEdge = $VerDetect }
                          $EdgeExists = $True
                      }
                  catch {
                          $EdgeExists = $False
                          Write-Host "EdgeNotFound"
                          Exit
                        }
                  $ErrorActionPreference = "Continue"
                  $EdgeDrvExists = Test-Path -Path $ScriptsPath\ObsData\msedgedriver.exe
                  Break
              }
    "Firefox" {
                  $ErrorActionPreference = "Stop"
                  try {
                          $VerFirefox = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe').'(Default)').VersionInfo.ProductVersion
                          $VerFirefox = $VerFirefox -replace '^(.+?)\..*$','$1'
                          $FirefoxExists = $True
                      }
                  catch {
                          $FirefoxExists = $False
                          Write-Host "FirefoxNotFound"
                          Exit
                        }
                  $ErrorActionPreference = "Continue"
                  $FirefoxDrvExists = Test-Path -Path $ScriptsPath\ObsData\geckodriver.exe
                  Break
              }
    default   {   # 不支援的瀏覽器
                  Write-Host "BrowserNotFound"
                  Exit
              }
}
$SeleniumDLLExists = Test-Path -Path $ScriptsPath\ObsData\WebDriver.dll

if (!(Test-Connection 8.8.8.8 -Quiet) 2>$null) {
    # 網路連線異常
    if (((Get-Variable $($BrowserType+'Exists')).value) -and ((Get-Variable $($BrowserType+'DrvExists')).value) -and $SeleniumDLLExists) {
        Write-Host "Skip"
    } else {
        Write-Host "Stop"
    }
    Exit
}

if (([System.Environment]::OSVersion.Version.Major -ge 10) -and ([System.Environment]::OSVersion.Version.Build -ge 17134)) {
    $Win10 = "Ture"
    Set-Alias -Name WinCurl -Value $Env:windir\System32\curl.exe
}
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$global:ProgressPreference = 'SilentlyContinue'

switch ($BrowserType)
{
    "Chrome"  {   # Chrome WebDriver
                  if (!$ChromeDrvExists) {
                      $ChromeURL = "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$VerChrome"
                      $DownVer = (Invoke-WebRequest -UseBasicParsing -Uri $ChromeURL).Content
                      $DownURL =  "https://chromedriver.storage.googleapis.com/$DownVer/chromedriver_win32.zip"
                      $ChromeFile = "chromedriver_win32_$DownVer.zip"
                      if ($Win10) { WinCurl -sL $DownURL --output "$ScriptsPath\$ChromeFile" } else {
                      Invoke-WebRequest -UseBasicParsing -Uri $DownURL -OutFile "$ScriptsPath\$ChromeFile" }
                      Expand-Archive "$ScriptsPath\$ChromeFile" "$ScriptsPath\WebDriverTemp" -Force
                      Move-Item "$ScriptsPath\WebDriverTemp\chromedriver.exe" "$ScriptsPath\ObsData" -Force
                      Remove-Item "$ScriptsPath\$ChromeFile" -Force
                      Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
                  }
                  Break
              }
    "Edge"    {   # Microsoft Edge (Chromium) WebDriver
                  if (!$EdgeDrvExists) {
                      $EdgeURL = "https://msedgedriver.azureedge.net/LATEST_RELEASE_$($VerEdge)_WINDOWS"
                      $data = [System.Text.Encoding]::Unicode.GetString((Invoke-WebRequest -UseBasicParsing -Uri $EdgeURL).Content)
                      $DownVer = $data.substring(1, ($data.length - 3))
                      if ([System.Environment]::Is64BitOperatingSystem) {
                          $DownURL = "https://msedgedriver.azureedge.net/$($DownVer)/edgedriver_win64.zip"
                          $EdgeFile = "edgedriver_win64_$DownVer.zip"
                      } else {
                          $DownURL = "https://msedgedriver.azureedge.net/$($DownVer)/edgedriver_win32.zip"
                          $EdgeFile = "edgedriver_win32_$DownVer.zip"
                      }
                      if ($Win10) { WinCurl -sL $DownURL --output "$ScriptsPath\$EdgeFile" } else {
                      Invoke-WebRequest -UseBasicParsing -Uri $DownURL -OutFile "$ScriptsPath\$EdgeFile" }
                      Expand-Archive "$ScriptsPath\$EdgeFile" "$ScriptsPath\WebDriverTemp" -Force
                      Move-Item "$ScriptsPath\WebDriverTemp\msedgedriver.exe" "$ScriptsPath\ObsData" -Force
                      Remove-Item "$ScriptsPath\$EdgeFile" -Force
                      Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
                  }
                  Break
              }
    "Firefox" {   # Firefox WebDriver
                  if (!$FirefoxDrvExists) {
                      $FirefoxURL = "https://api.github.com/repos/mozilla/geckodriver/releases"
                      $data = Invoke-WebRequest -UseBasicParsing -Uri $FirefoxURL | ConvertFrom-Json
                      $i = 0
                      if ([System.Environment]::Is64BitOperatingSystem) {
                          for ($index=0; $index -lt $data[$i].assets.Length; $index++) {
                              if ($data[$i].assets[$index].name -match '(geckodriver-.*-win64\.zip)$') {
                                  $DownName = $data[$i].assets[$index].name
                                  $DownURL = $data[$i].assets[$index].browser_download_url
                                  $DownVer = $data[$i].name
                                  break
                              }
                          }
                      } else {
                          for ($index=0; $index -lt $data[$i].assets.Length; $index++) {
                              if ($data[$i].assets[$index].name -match '(geckodriver-.*-win32\.zip)$') {
                                  $DownName = $data[$i].assets[$index].name
                                  $DownURL = $data[$i].assets[$index].browser_download_url
                                  $DownVer = $data[$i].name
                                  break
                              }
                          }                      
                      }
                      $FirefoxFile = $DownName
                      if ($Win10) { WinCurl -sL $DownURL --output "$ScriptsPath\$FirefoxFile" } else {
                      Invoke-WebRequest -UseBasicParsing -Uri $DownURL -OutFile "$ScriptsPath\$FirefoxFile" }
                      Expand-Archive "$ScriptsPath\$FirefoxFile" "$ScriptsPath\WebDriverTemp" -Force
                      Move-Item "$ScriptsPath\WebDriverTemp\geckodriver.exe" "$ScriptsPath\ObsData" -Force
                      Remove-Item "$ScriptsPath\$FirefoxFile" -Force
                      Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
                  }
                  Break
              }
}

# Selenium
if (!(Test-Path -Path $ScriptsPath\ObsData\WebDriver.dll)) {
    $SeleniumURL = "https://www.selenium.dev/downloads/"
    $data = (Invoke-WebRequest -UseBasicParsing -Uri $SeleniumURL).ToString()
    $RegEx = '.*<table.*C#.*?(https:\/\/[^\s]+)\sclass=link>Beta\sDownload<\/a>.*$'
    $RegExOptions = [System.Text.RegularExpressions.RegexOptions]::Singleline
    $DownURL = [regex]::Match($data, $RegEx, $RegExOptions).captures.groups[1].value
    $DownVer = [regex]::Match($DownURL,'.*Selenium.WebDriver/(.*)$').captures.groups[1].value
    $SeleniumFile = "selenium.webdriver.$DownVer.nupkg"
    if ($Win10) { WinCurl -sL $DownURL --output "$ScriptsPath\$SeleniumFile" } else {
    Invoke-WebRequest -UseBasicParsing -Uri $DownURL -OutFile "$ScriptsPath\$SeleniumFile" }
    Rename-Item "$ScriptsPath\$SeleniumFile" "$ScriptsPath\$SeleniumFile.zip"
    Expand-Archive "$ScriptsPath\$SeleniumFile.zip" "$ScriptsPath\WebDriverTemp" -Force
    Move-Item "$ScriptsPath\WebDriverTemp\lib\net48\WebDriver.dll" "$ScriptsPath\ObsData" -Force
    Remove-Item "$ScriptsPath\$SeleniumFile.zip" -Force
    Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
}
$global:ProgressPreference = 'Continue'

Write-Host "Kick"
