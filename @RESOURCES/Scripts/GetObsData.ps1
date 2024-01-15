###########################################################
#  By Proliantaholic https://proliantaholic.blogspot.com  #
###########################################################

param (
    [string]$ScriptsPath = ".",
    [string]$BrowserType = "Chrome",
    [string]$StationId = "46692", # 臺北
    [string]$CountyId = "63", # 臺北市
    [string]$TownId = "6300500", # 臺北市中正區
    [string]$CheckWebDriver = "Yes",
    [string]$PingPong = "Ping"
)
$ObsDataPath = "$ScriptsPath\ObsData"

[Console]::OutputEncoding=[Text.Encoding]::UTF8
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$URL = "https://www.cwa.gov.tw/V8/C/W/OBS_Station.html?ID=$StationId"


function WebDriverGet {
    if (!(Test-Path -Path $ScriptsPath\ObsData\)) {
        New-Item -Path $ObsDataPath -ItemType Directory -ea SilentlyContinue | Out-Null
    }

    $DriverList = @{ 'Chrome' = 'chromedriver'; 'Edge' = 'msedgedriver'; 'Firefox' = 'geckodriver' }
    $DriverExists = Test-Path -Path "$ScriptsPath\ObsData\$($DriverList[$BrowserType]).exe"
    $JsonNetDLLExists = Test-Path -Path $ScriptsPath\ObsData\Newtonsoft.Json.dll
    $SeleniumDLLExists = Test-Path -Path $ScriptsPath\ObsData\WebDriver.dll
    Add-Type -Assembly "System.IO.Compression.Filesystem"
    Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force -ea SilentlyContinue

    $ErrorActionPreference = "Stop"
    switch ($BrowserType) {
        "Chrome" {
            try {
                $VerChrome = (Get-Item ([regex]::Replace((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(default)','(\\Chrome.*\\Application)','\Chrome\Application'))).VersionInfo.ProductVersion
                $BrowserExists = $True
            }
            catch {
                return "BrowserNotFound"
            }
            break
        }
        "Edge" {
            try {
                $VerMajor = (Get-Item ([regex]::Replace((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe').'(default)','(\\Edge.*\\Application)','\Edge\Application'))).VersionInfo.ProductVersion -replace '^(.+?)\..*$', '$1'
                $BrowserExists = $True
            }
            catch {
                return "BrowserNotFound"
            }
            break
        }
        "Firefox" {
            try {
                $VerFirefox = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe').'(Default)').VersionInfo.ProductVersion
                $BrowserExists = $True
            }
            catch {
                return "BrowserNotFound"
            }
            break
        }
        default {
            return "BrowserNotFound"
        }
    }
    $ErrorActionPreference = "Continue"

    if (!(Test-Connection 8.8.8.8 -Quiet -ea SilentlyContinue)) {
        # 網路連線異常
        if ($BrowserExists -and $DriverExists -and $JsonNetDLLExists -and $SeleniumDLLExists) {
            return "Skip"
        }
        else {
            return "Stop"
        }
    }

    switch ($BrowserType) {
        "Chrome" {
            # Chrome WebDriver
            $ChromeURL = "https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json"
            if ($DriverExists) {
                try {
                    $data = Invoke-RestMethod -Method Get -Uri $ChromeURL
                    $DownVer = $data.channels.Stable.version
                }
                catch {
                    $Download = $False
                    break
                }
                $DriverVersion = [regex]::Match((& $ScriptsPath\ObsData\$($DriverList[$BrowserType]).exe -V), '\d+(?:\.\d+){2,3}').captures.groups[0].value
                if ([System.Version]$DownVer -gt [System.Version]$DriverVersion) {
                    $Download = $True
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
                    try {
                        $data = Invoke-RestMethod -Method Get -Uri $ChromeURL
                    }
                    catch {
                        return "Stop"
                    }
                }
                $ChromeFile = "chromedriver-win64.zip"
                for ($i=($data.channels.Stable.downloads.chromedriver.platform.length -1); $i -ge 0; $i--) {
                    if ($data.channels.Stable.downloads.chromedriver.platform[$i] -eq "win64") {
                        $DownURL = $data.channels.Stable.downloads.chromedriver[$i].url
                        break
                    }
                }
                if (![System.Environment]::Is64BitOperatingSystem) {
                    $ChromeFile = "chromedriver-win32.zip"
                    for ($i=($data.channels.Stable.downloads.chromedriver.platform.length -1); $i -ge 0; $i--) {
                        if ($data.channels.Stable.downloads.chromedriver.platform[$i] -eq "win32") {
                            $DownURL = $data.channels.Stable.downloads.chromedriver[$i].url
                            break
                        }
                    }
                }
                (New-Object -TypeName System.Net.WebClient).DownloadFile($DownURL, "$ScriptsPath\$ChromeFile")
                [System.IO.Compression.ZipFile]::ExtractToDirectory("$ScriptsPath\$ChromeFile", "$ScriptsPath\WebDriverTemp")
                Move-Item "$ScriptsPath\WebDriverTemp\chromedriver-win64\chromedriver.exe" "$ScriptsPath\ObsData" -Force -ea SilentlyContinue
                if (![System.Environment]::Is64BitOperatingSystem) {
                    Move-Item "$ScriptsPath\WebDriverTemp\chromedriver-win32\chromedriver.exe" "$ScriptsPath\ObsData" -Force -ea SilentlyContinue
                }
                Remove-Item "$ScriptsPath\$ChromeFile" -Force
                Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
            }
            break
        }
        "Edge" {
            # Microsoft Edge (Chromium) WebDriver
            $EdgeURL = "https://msedgedriver.azureedge.net/LATEST_RELEASE_$($VerMajor)_WINDOWS"
            if ($DriverExists) {
                try {
                    $VerString = [System.Text.Encoding]::Unicode.GetString((Invoke-WebRequest -UseBasicParsing -Uri $EdgeURL).Content)
                    $DownVer = $VerString.substring(1, ($VerString.length - 3))
                }
                catch {
                    $Download = $False
                    break
                }
                $DriverVersion = (Get-Item "$ScriptsPath\ObsData\$($DriverList[$BrowserType]).exe").VersionInfo.ProductVersion
                if ([System.Version]$DownVer -gt [System.Version]$DriverVersion) {
                    $Download = $True
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
                    try {
                        $data = [System.Text.Encoding]::Unicode.GetString((Invoke-WebRequest -UseBasicParsing -Uri $EdgeURL).Content)
                        $DownVer = $data.substring(1, ($data.length - 3))
                    }
                    catch {
                        return "Stop"
                    }
                }
                $EdgeFile = "edgedriver_win64.zip"
                $DownURL = "https://msedgedriver.azureedge.net/$($DownVer)/" + $EdgeFile
                if (![System.Environment]::Is64BitOperatingSystem) {
                    $EdgeFile = "edgedriver_win32.zip"
                    $DownURL = "https://msedgedriver.azureedge.net/$($DownVer)/" + $EdgeFile
                }
                (New-Object -TypeName System.Net.WebClient).DownloadFile($DownURL, "$ScriptsPath\$EdgeFile")
                [System.IO.Compression.ZipFile]::ExtractToDirectory("$ScriptsPath\$EdgeFile", "$ScriptsPath\WebDriverTemp")
                Move-Item "$ScriptsPath\WebDriverTemp\msedgedriver.exe" "$ScriptsPath\ObsData" -Force -ea SilentlyContinue
                Remove-Item "$ScriptsPath\$EdgeFile" -Force
                Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
            }
            break
        }
        "Firefox" {
            # Firefox WebDriver
            $FirefoxURL = "https://api.github.com/repos/mozilla/geckodriver/releases"
            if ($DriverExists) {
                try {
                    $data = Invoke-RestMethod -Method Get -Uri $FirefoxURL
                    $DownVer = $data[0].tag_name
                }
                catch {
                    $Download = $False
                    break
                }
                $FirefoxFile = "geckodriver-" + $DownVer + "-win64.zip"
                $DownURL = "https://github.com/mozilla/geckodriver/releases/download/" + $DownVer + "/" + $FirefoxFile
                if (![System.Environment]::Is64BitOperatingSystem) {
                    $FirefoxFile = "geckodriver-" + $DownVer + "-win32.zip"
                    $DownURL = "https://github.com/mozilla/geckodriver/releases/download/" + $DownVer + "/" + $FirefoxFile
                }
                $DriverVersion = [regex]::Match((& $ScriptsPath\ObsData\$($DriverList[$BrowserType]).exe -V), '\d+(?:\.\d+){2,3}').captures.groups[0].value
                if ([System.Version]$data[0].name -gt [System.Version]$DriverVersion) {
                    $Download = $True
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
                    try {
                        $data = Invoke-RestMethod -Method Get -Uri $FirefoxURL
                        $DownVer = $data[0].tag_name
                    }
                    catch {
                        return "Stop"
                    }
                    $FirefoxFile = "geckodriver-" + $DownVer + "-win64.zip"
                    $DownURL = "https://github.com/mozilla/geckodriver/releases/download/" + $DownVer + "/" + $FirefoxFile
                    if (![System.Environment]::Is64BitOperatingSystem) {
                        $FirefoxFile = "geckodriver-" + $DownVer + "-win32.zip"
                        $DownURL = "https://github.com/mozilla/geckodriver/releases/download/" + $DownVer + "/" + $FirefoxFile
                    }
                }
                (New-Object -TypeName System.Net.WebClient).DownloadFile($DownURL, "$ScriptsPath\$FirefoxFile")
                [System.IO.Compression.ZipFile]::ExtractToDirectory("$ScriptsPath\$FirefoxFile", "$ScriptsPath\WebDriverTemp")
                Move-Item "$ScriptsPath\WebDriverTemp\geckodriver.exe" "$ScriptsPath\ObsData" -Force -ea SilentlyContinue
                Remove-Item "$ScriptsPath\$FirefoxFile" -Force
                Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
            }
            break
        }
    }

    # Json.NET
    $JsonNetURL = "https://api.github.com/repos/JamesNK/Newtonsoft.Json/releases"
    $Download = $True
    if ($JsonNetDLLExists) {
        try {
            $data = Invoke-RestMethod -Method Get -Uri $JsonNetURL
            $DownVer = $data[0].name
            $DriverVersion = (Get-Item "$ScriptsPath\ObsData\Newtonsoft.Json.dll").VersionInfo.FileVersion
    
            if ([System.Version]$DownVer -le [System.Version]$DriverVersion) {
                $Download = $False
            }
        }
        catch {
            $Download = $False
        }
    }
    if ($Download) {
        if (!$JsonNetDLLExists) {
            try {
                $data = Invoke-RestMethod -Method Get -Uri $JsonNetURL
            }
            catch {
                return "Stop"
            }
        }
        $DownURL = $data[0].assets.browser_download_url
        $JsonNetFile = $data[0].assets.name
        (New-Object -TypeName System.Net.WebClient).DownloadFile($DownURL, "$ScriptsPath\$JsonNetFile")
        [System.IO.Compression.ZipFile]::ExtractToDirectory("$ScriptsPath\$JsonNetFile", "$ScriptsPath\WebDriverTemp")
        Move-Item "$ScriptsPath\WebDriverTemp\Bin\netstandard2.0\Newtonsoft.Json.dll" "$ScriptsPath\ObsData" -Force -ea SilentlyContinue
        Remove-Item "$ScriptsPath\$JsonNetFile" -Force
        Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
    }
    
    # Selenium
    $SeleniumURL = "https://api.nuget.org/v3-flatcontainer/selenium.webdriver/index.json"
    $Download = $True
    if ($SeleniumDLLExists) {
        try {
            $data = Invoke-RestMethod -Method Get -Uri $SeleniumURL
            $DownVer = $data.versions[-1]
            $DriverVersion = (Get-Item "$ScriptsPath\ObsData\WebDriver.dll").VersionInfo.ProductVersion
            if ($DownVer -le $DriverVersion) {
                $Download = $False
            }
        }
        catch {
            $Download = $False
        }
    }
    if ($Download) {
        if (!$SeleniumDLLExists) {
            try {
                $data = Invoke-RestMethod -Method Get -Uri $SeleniumURL
                $DownVer = $data.versions[-1]
            }
            catch {
                return "Stop"
            }
        }
        # $DownVer = "4.0.0-beta2"   # 下載特定版本: comment $data, $DownVer
        $DownURL = "https://www.nuget.org/api/v2/package/Selenium.WebDriver/" + $DownVer
        $SeleniumFile = "selenium.webdriver.$DownVer.nupkg"
        (New-Object -TypeName System.Net.WebClient).DownloadFile($DownURL, "$ScriptsPath\$SeleniumFile")
        Rename-Item "$ScriptsPath\$SeleniumFile" "$ScriptsPath\$SeleniumFile.zip"
        [System.IO.Compression.ZipFile]::ExtractToDirectory("$ScriptsPath\$SeleniumFile.zip", "$ScriptsPath\WebDriverTemp")
        Move-Item "$ScriptsPath\WebDriverTemp\lib\netstandard2.0\WebDriver.dll" "$ScriptsPath\ObsData" -Force -ea SilentlyContinue
        Remove-Item "$ScriptsPath\$SeleniumFile.zip" -Force
        Remove-Item "$ScriptsPath\WebDriverTemp" -Recurse -Force
    }
    return "Kick"
}


function ObsDataGet {
    if (!(Test-Connection 8.8.8.8 -Quiet -ea SilentlyContinue)) {
        # 網路連線異常
        try {
            # 如果前一次資料正常則沿用, 但是把 $obsDataStatus/$P[1].P3 改為 網路連線異常
            $Header = 'P1','P2','P3','P4','P5','P6','P7','P8','P9','P10','P11','P12','P13','P14','P15','P16','P17','P18','P19','P20','P21','P22','P23','P24','P25','P26','P27','P28','P29','P30'
            if ((($P = Import-Csv "$ObsDataPath\ObsData.txt" -Header $Header -Encoding Unicode).Count -ne $null) -and ($P[1].P3 -eq "正常")) {
                $P[1].P2 += "📶🈚"
                $P[1].P3 = "網路連線異常"
                $P[1].P30 = $BrowserType
                if ($P[1].P11 -ne "") { $P[1].P11 = " " + $P[1].P11 }
                $obsLine = ""
                for ($i=1; $i -le 30; $i++) { $obsLine += $P[1]."P$($i)" + "," }
                Write-Host "Skip"
                Write-Host $obsLine
                return
            }
        }
        catch {}
        $StationName = "網路連線異常"
        $obsDataStatus = "網路連線異常"
        $obsDataRowCount = "0"
        $mmdd = Get-Date -Format 'MM/dd'
        $HHMM = Get-Date -Format 'HH:mm'
        $tem = ""
        $weather = "-"
        $weatherL1 = ""
        $weatherL2 = ""
        $w1 = " -"
        $w2 = "-"
        $w3 = "-"
        $visible = "-"
        $hum = "-"
        $pre = "-"
        $rain = "-"
        $sunlight = "-"
        $SSTimeSunRize = $(Get-Date -Format 'yyyy/MM/dd 06:00')
        $SSTimeSunSet  = $(Get-Date -Format 'yyyy/MM/dd 18:00')
        if (((Get-Date) -ge (Get-Date -Date $SSTimeSunRize)) -and (((Get-Date) -lt (Get-Date -Date $SSTimeSunSet)))) {
            $DayOrNight = 'DAY'
        } else {
            $DayOrNight = 'NIGHT'
        }
        $TownId = "體感溫度異常"
        $TownName = ""
        $ApptTemp = ""
        $ApptTempTime = "-"
        $PoP6h = ""
        Write-Host "Skip"
        Write-Host $StationId","$StationName","$obsDataStatus","$obsDataRowCount","$mmdd","$HHMM","$tem","$weather","$weatherL1","$weatherL2","$w1","$w2","$w3","$visible","$hum","$pre","$rain","$sunlight"," -NoNewline
        Write-Host $SSTimeSunRize","$SSTimeSunSet","$DayOrNight","$TownId","$TownName","$ApptTemp","$ApptTempTime","$PoP6h"," -NoNewline
        Write-Host 資料來源:中央氣象署全球資訊網","$URL"," -NoNewline
        Write-Host $ObsDataPath","$BrowserType","
        return
    }

    $DriverList = @{ 'Chrome' = 'chromedriver.exe'; 'Edge' = 'msedgedriver.exe'; 'Firefox' = 'geckodriver.exe' }
    $WebDriverExe = $DriverList[$BrowserType]
    Add-Type -Path "$($ObsDataPath)\WebDriver.dll"

    switch ($BrowserType)
    {
        'Chrome'  {
                      $BrowserOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
                      $BrowserOptions.AddArguments([string[]]('--headless', '--incognito', '--blink-settings=imagesEnabled=false'))
                      $BrowserOptions.PageLoadStrategy = "eager"

                      $service = [OpenQA.Selenium.Chrome.ChromeDriverService]::CreateDefaultService($ObsDataPath, $WebDriverExe)
                      $service.HideCommandPromptWindow = $true

                      $BrowserDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($service, $BrowserOptions)
                      break
                  }
        'Edge'    {
                      $BrowserOptions = New-Object OpenQA.Selenium.Edge.EdgeOptions
                      $BrowserOptions.AddArguments([string[]]('--headless', '--inprivate', '--blink-settings=imagesEnabled=false'))
                      $BrowserOptions.PageLoadStrategy = "eager"

                      $service = [OpenQA.Selenium.Edge.EdgeDriverService]::CreateDefaultService($ObsDataPath, $WebDriverExe)
                      $service.HideCommandPromptWindow = $true

                      $BrowserDriver = New-Object OpenQA.Selenium.Edge.EdgeDriver($service, $BrowserOptions)
                      break
                  }
        'Firefox' {
                      $BrowserOptions = New-Object OpenQA.Selenium.Firefox.FirefoxOptions
                      $BrowserOptions.AddArguments([string[]]('--headless', '--private-window'))
                      $BrowserOptions.SetPreference([string]'permissions.default.image', [int]2)
                      $BrowserOptions.PageLoadStrategy = "eager"

                      $service = [OpenQA.Selenium.Firefox.FirefoxDriverService]::CreateDefaultService($ObsDataPath, $WebDriverExe)
                      $service.HideCommandPromptWindow = $true

                      $BrowserDriver = New-Object OpenQA.Selenium.Firefox.FirefoxDriver($service, $BrowserOptions)
                      break
                  }
    }

    try {
        $BrowserDriver.Navigate().GoToURL($URL)
        Do {
            Start-Sleep -Milliseconds 100
        } Until ($BrowserDriver.ExecuteScript('return document.readyState') -eq "complete")
    }
    catch {
        $message1 = $_.Exception
        try {
            $BrowserDriver.Navigate().Refresh()
            Do {
                Start-Sleep -Milliseconds 100
            } Until ($BrowserDriver.ExecuteScript('return document.readyState') -eq "complete")
        }
        catch {
            $message2 = $_.Exception
        }
    }

    switch ($obsDataRowCount = $BrowserDriver.FindElements('xpath', '//*[@id="obstime"]/tr').Count)
    {
        0       {   # 無觀測資料或無此測站
                    $obsDataStatus = "無觀測資料"
                    $StationName = "無觀測資料或無此測站"
                    $time = "-"
                    $mmdd = Get-Date -Format 'MM/dd'
                    $HHMM = Get-Date -Format 'HH:mm'
                    $tem = ""
                    $weather = "-"
                    $weatherL1 = ""
                    $weatherL2 = ""
                    $w1 = " -"
                    $w2 = "-"
                    $w3 = "-"
                    $visible = "-"
                    $hum = "-"
                    $pre = "-"
                    $rain = "-"
                    $sunlight = "-"
                    break
                }
        1       {   # 測站儀器故障, 儀器調校中
                    $obsDataStatus =  $BrowserDriver.FindElements('css selector', '#obstime > tr:nth-child(1)').Text
                    $StationName = $BrowserDriver.FindElement('css selector', '#BarStationName').getAttribute('innerHTML') + "🈚"
                    $time = "-"
                    $mmdd = Get-Date -UFormat '%m/%d'
                    $HHMM = Get-Date -UFormat '%H:%M'
                    $weather = "-"
                    $weatherL1 = ""
                    $weatherL2 = ""
                    if ($obsDataStatus -eq "儀器故障") {
                        $tem = "故障"
                        $w1 = ""
                        $w2 = "儀器故障"
                        $w3 = "故障"
                        $visible = "故障"
                        $hum = "故障"
                        $pre = "儀器故障"
                        $rain = "儀器故障"
                        $sunlight = "儀器故障"
                    } else {
                        $tem = "調校"
                        $w1 = ""
                        $w2 = "調校中"
                        $w3 = "調校"
                        $visible = "調校"
                        $hum = "調校"
                        $pre = "調校中"
                        $rain = "調校中"
                        $sunlight = "儀器調校中"
                    }
                    break
                }
        default {   # 正常 (10分鐘更新150列, 1小時更新25列)
                    $obsDataStatus = "正常"
                    $StationName = $BrowserDriver.FindElement('css selector', '#BarStationName').getAttribute('innerHTML')
                    $time = $BrowserDriver.FindElement('xpath', '//*[@id="obstime"]/tr/th[@headers="time"]').Text -match '(?<mmdd>.*)\r\n(?<HHMM>.*)'
                    $mmdd = $Matches.mmdd
                    $HHMM = $Matches.HHMM
                    $tem = $BrowserDriver.FindElement('xpath', '//*[@id="obstime"]/tr[1]/td[@headers="temp"]').Text
                    try {
                        $tem = [regex]::Match($tem,"^(儀器)(故障|調校)(.*)").groups.captures[2].value
                    }
                    catch {
                        $tem = ($tem + "°" ) -replace '(^-°$)', ''
                    }
                    if (($BrowserDriver.FindElements('xpath', '//*[@id="obstime"]/tr[1]/td[@headers="weather"]/img').Count) -ne 0) { 
                        $weather = $BrowserDriver.FindElement('xpath', '//*[@id="obstime"]/tr[1]/td[@headers="weather"]/img').getAttribute('title')
                        try {
                            $weatherTemp = [regex]::Match($weather,"^(晴|多雲|陰)(.*)")
                            $weatherL1 = $weatherTemp.captures.groups[1].value
                            $weatherL2 = $weatherTemp.captures.groups[2].value
                        }
                        catch {
                            $weatherL1 = $weather
                            $weatherL2 = ""
                        }
                    } else {
                        $weather = "-"
                        $weatherL1 = ""
                        $weatherL2 = ""
                    }
                    $w1 = $BrowserDriver.FindElement('xpath', '//*[@id="obstime"]/tr[1]/td[@headers="w-1"]/span[@class="wind"]').getAttribute('innerHTML')
                    if ($w1 -match "^(?!儀器.*)") {
                        $w1 = $w1 -replace '^風向不定$', '不定'
                        $w1 = " " + $($w1 -replace '^－$', '-') # Replace Unicode minus sign U+FF0D "－" ef bc 8d
                    } else {
                        $w1 = ""
                    }
                    $w2 = $BrowserDriver.FindElement('xpath', '//*[@id="obstime"]/tr[1]/td[@headers="w-2"]/span[@class="wind_1 is-active"]').getAttribute('innerHTML')
                    try { $w2 = [regex]::Match($w2,"^(儀器)(調校中)(.*)").groups.captures[2].value } catch {}
                    $w3 = $BrowserDriver.FindElement('xpath', '//*[@id="obstime"]/tr[1]/td[@headers="w-3"]/span[@class="wind_1 is-active"]').getAttribute('innerHTML')
                    try { $w3 = [regex]::Match($w3,"^(儀器)(故障|調校)(.*)").groups.captures[2].value } catch {}
                    $visible = $BrowserDriver.FindElement('css selector', '#obstime > tr:nth-child(1) > td:nth-child(7)').getAttribute('innerHTML')
                    try { $visible = [regex]::Match($visible,"^(儀器)(故障|調校)(.*)").groups.captures[2].value } catch {}
                    $hum = $BrowserDriver.FindElement('css selector', '#obstime > tr:nth-child(1) > td:nth-child(8)').getAttribute('innerHTML')
                    try { $hum = [regex]::Match($hum,"^(儀器)(故障|調校)(.*)").groups.captures[2].value } catch { $hum = $hum -replace '(?!^-$)(.+)', '$1%' }
                    $pre = $BrowserDriver.FindElement('css selector', '#obstime > tr:nth-child(1) > td:nth-child(9)').getAttribute('innerHTML')
                    try { $pre = [regex]::Match($pre,"^(儀器)(調校中)(.*)").groups.captures[2].value } catch {}
                    $rain = $BrowserDriver.FindElement('css selector', '#obstime > tr:nth-child(1) > td:nth-child(10)').getAttribute('innerHTML')
                    try { $rain = [regex]::Match($rain,"^(儀器)(調校中)(.*)").groups.captures[2].value } catch {}
                    $sunlight = $BrowserDriver.FindElement('css selector', '#obstime > tr:nth-child(1) > td:nth-child(11)').getAttribute('innerHTML')
                    break
                }
    }

    # ApptTemp and PoP6h
    $ApptTempURL = "https://www.cwa.gov.tw/V8/C/W/Town/Town.html?TID=$($TownId)"
    $TownName = ""
    $ApptTemp = ""
    $ApptTempTime = "-"
    $PoP6h = ""
    if ($StationName -ne "無觀測資料或無此測站") {
        try {
            $BrowserDriver.Navigate().GoToURL($ApptTempURL)
            Do {
                Start-Sleep -Milliseconds 100
            } Until ($BrowserDriver.ExecuteScript('return document.readyState') -eq "complete")
            $TownName = $BrowserDriver.FindElement('css selector', '#PageTitle').getAttribute('innerHTML')
            $ApptTemp = $BrowserDriver.FindElement('xpath', '/html/body/div[2]/main/div/div[1]/table/tbody/tr/td[3]/span/span[1]').getAttribute('innerHTML') + "°"
            $ApptTemp = $ApptTemp -replace '(^-°$)', ''
            $ApptTempTime = $BrowserDriver.FindElement('xpath', '/html/body/div[2]/main/div/div[1]/table/tbody/tr/td[1]/span').getAttribute('innerHTML')
            $ApptTempTime = [regex]::Match($ApptTempTime,'.*<br>.*<br>(.*)').captures.groups[1].value
            $PoP6h = $BrowserDriver.FindElement('xpath', '/html/body/div[2]/main/div/div[2]/div[3]/div[1]/div[1]/table[1]/tbody/tr[5]/td[1]').getAttribute('innerHTML')
        }
        catch {
            $message3 = $_.Exception
            $BrowserDriver.Navigate().Refresh()
            Do {
                Start-Sleep -Milliseconds 100
            } Until ($BrowserDriver.ExecuteScript('return document.readyState') -eq "complete")
            try {
                $TownName = $BrowserDriver.FindElement('css selector', '#PageTitle').getAttribute('innerHTML')
                $ApptTemp = $BrowserDriver.FindElement('xpath', '/html/body/div[2]/main/div/div[1]/table/tbody/tr/td[3]/span/span[1]').getAttribute('innerHTML') + "°"
                $ApptTemp = $ApptTemp -replace '(^-°$)', ''
                $ApptTempTime = $BrowserDriver.FindElement('xpath', '/html/body/div[2]/main/div/div[1]/table/tbody/tr/td[1]/span').getAttribute('innerHTML')
                $ApptTempTime = [regex]::Match($ApptTempTime,'.*<br>.*<br>(.*)').captures.groups[1].value
                $PoP6h = $BrowserDriver.FindElement('xpath', '/html/body/div[2]/main/div/div[2]/div[3]/div[1]/div[1]/table[1]/tbody/tr[5]/td[1]').getAttribute('innerHTML')
            }
            catch {
                $message4 = $_.Exception
                $TownId = "體感溫度異常"
            }
        }
    }

    # SSTime
    $SSTimeURL = "https://www.cwa.gov.tw/V8/C/W/County/MOD/SunMoon/63_SunMoon.html"
    if ($StationName -ne "無觀測資料或無此測站") {
        $SSTimeURL = "https://www.cwa.gov.tw/V8/C/W/County/MOD/SunMoon/$($CountyId)_SunMoon.html"
    }
    $Now = Get-Date
    $NowMonthDay = $Now.ToString('MM/dd')
     try {
         $BrowserDriver.Navigate().GoToURL($SSTimeURL)
         Do {
             Start-Sleep -Milliseconds 100
         } Until ($BrowserDriver.ExecuteScript('return document.readyState') -eq "complete")
         $SSTimeMonthDay = $BrowserDriver.FindElement('xpath', '/html/body/div[1]').Text
         $SSTimeSunRize= $BrowserDriver.FindElement('xpath', '/html/body/div[2]/table/tbody/tr/td[1]').Text
         $SSTimeSunSet = $BrowserDriver.FindElement('xpath', '/html/body/div[2]/table/tbody/tr/td[2]').Text
         if ("" -eq $SSTimeSunRize) {
             $SSTimeMonthDay = $NowMonthDay
             $SSTimeSunRize = "06:00"
             $SSTimeSunSet = "18:00"
         }
     }
     catch {
         $SSTimeMonthDay = $NowMonthDay
         $SSTimeSunRize = "06:00"
         $SSTimeSunSet = "18:00"
     }
     $SSTimeSunRize = Get-Date -Format "yyyy/$($SSTimeMonthDay) $($SSTimeSunRize)"
     $SSTimeSunSet = Get-Date -Format "yyyy/$($SSTimeMonthDay) $($SSTimeSunSet)"

    # DAY or NIGHT
    if (($Now -ge [datetime]$SSTimeSunRize) -and (($Now - [datetime]$SSTimeSunSet).TotalMinutes -lt -15)) {
        $DayOrNight = 'DAY'
    } else {
        $DayOrNight = 'NIGHT'
    }

    $BrowserDriver.Quit()

    Write-Host $Action
    Write-Host $StationId","$StationName","$obsDataStatus","$obsDataRowCount","$mmdd","$HHMM","$tem","$weather","$weatherL1","$weatherL2","$w1","$w2","$w3","$visible","$hum","$pre","$rain","$sunlight"," -NoNewline
    Write-Host $SSTimeSunRize","$SSTimeSunSet","$DayOrNight","$TownId","$TownName","$ApptTemp","$ApptTempTime","$PoP6h"," -NoNewline
    Write-Host 資料來源:中央氣象署全球資訊網","$URL"," -NoNewline
    Write-Host $ObsDataPath","$BrowserType","
    
}


# Main
if ($CheckWebDriver -eq "Yes") {
    switch (WebDriverGet) {
            "Kick" {
                $Action = "Kick$($PingPong)"
                break
            }
            "Skip" {
                $Action = "Skip"
                break
            }
            "BrowserNotFound" {
                Write-Host "BrowserNotFound"
                Exit
            }
            "Stop" {
                Write-Host "Stop"
                Exit
            }
    }
}
else {
    $Action = "Kick$($PingPong)"
}

ObsDataGet


# $StationId       ->  [ObsData1StationId]             ; 測站站號
# $StationName     ->  [ObsData2StationName]           ; 測站站名 
# $obsDataStatus   ->  [ObsData3DataStatus]            ; 測站狀態 (正常, 儀器故障, 儀器調校中, 網路連線異常)
# $obsDataRowCount ->  [ObsData4DataRowCount]          ; 觀測資料列數 (判斷測站狀態依據)
# $mmdd            ->  [ObsData5DataTimemmdd]          ; 觀測時間 (月日)
# $HHMM            ->  [ObsData6DataTimeHHMM]          ; 觀測時間 (時分)
# $tem             ->  [ObsData7TEMP]                  ; 溫度
# $weather         ->  [ObsData8Weather]               ; 天氣狀況
# $weatherL1       ->  [ObsData9WeatherL1]             ; 天氣描述Line1 (雲量)
# $weatherL2       ->  [ObsData10WeatherL2]            ; 天氣描述Line2 (天氣現象)
# $w1              ->  [ObsData11WindDirection]        ; 風向
# $w2              ->  [ObsData12Wind]                 ; 風力(級)
# $w3              ->  [ObsData13Gust]                 ; 陣風(級)
# $visible         ->  [ObsData14Visibility]           ; 能見度(公里)
# $hum             ->  [ObsData15HUMD]                 ; 相對濕度(%)
# $pre             ->  [ObsData16AtmosphericPressure]  ; 海平面氣壓(百帕)
# $rain            ->  [ObsData17Rain1day]             ; 當日累積雨量(毫米)
# $sunlight        ->  [ObsData18Sunlight]             ; 日照時數
# $SSTimeSunRize   ->  [ObsData19SSTimeSunRize]        ; 日出時刻 yyyy/MM/dd HH:mm -> HH:mm
# $SSTimeSunSet    ->  [ObsData20SSTimeSunSet]         ; 日沒時刻 yyyy/MM/dd HH:mm -> HH:mm
# $DayOrNight      ->  [ObsData21DayOrNight]           ; 白天夜晚 (DAY, NIGHT)
# $TownId          ->  [ObsData22TownId]               ; 測站區鄉鎮代碼
# $TownName        ->  [ObsData23TownName]             ; 測站區鄉鎮名稱
# $ApptTemp        ->  [ObsData24ApptTemp]             ; 體感溫度
# $ApptTempTime    ->  [ObsData25ApptTempTime]         ; 體感溫度預報時間
# $PoP6h           ->  [ObsData26PoP6h]                ; 六小時降雨機率

# 資料來源:中央氣象署全球資訊網  ->  [ObsData27DataSource]   ; 資料來源聲明
# $URL                           ->  [ObsData28URL]          ; 資料來源URL
# $ObsDataPath                   ->  [ObsData29ObsDataPath]  ; ObsData路徑
# $BrowserType                   ->  [ObsData30BrowserType]  ; 瀏覽器 (Edge, Chrome, Firefox)
