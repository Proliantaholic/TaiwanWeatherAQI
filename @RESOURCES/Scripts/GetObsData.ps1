###########################################################
#  By Proliantaholic https://proliantaholic.blogspot.com  #
###########################################################

param (
    [string]$ScriptsPath = ".",
    [string]$ConnectionOK = "10", # 正常: ms, 斷線: NoConnection
    [string]$StationId = "46692", # 臺北
    [string]$CountyId = "63",     # 臺北市
    [string]$TownId = "6300500",  # 臺北市中正區
    [string]$CheckPkg = "Yes",
    [string]$PingPong = "Ping",
    [string]$MyUserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36"
)
$ObsDataPath = "$ScriptsPath\ObsData"

[Console]::OutputEncoding=[Text.Encoding]::UTF8
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


function GetRqdPkg {
    if (!(Test-Path -Path $ScriptsPath\ObsData\)) {
        New-Item -Path $ObsDataPath -ItemType Directory -ea SilentlyContinue | Out-Null
    }

    $HAPDLLExists = Test-Path -Path $ObsDataPath\HtmlAgilityPack.dll
    Add-Type -Assembly "System.IO.Compression.Filesystem"
    Remove-Item "$ScriptsPath\TempFolder" -Recurse -Force -ea SilentlyContinue

    if ($ConnectionOK -eq "NoConnection") {
        # 網路連線異常
        if ($HAPDLLExists) {
            return "Skip"
        }
        else {
            return "Stop"
        }
    }

    # Html Agility Pack
    $HAPURL = "https://api.nuget.org/v3-flatcontainer/HtmlAgilityPack/index.json"
    $Download = $True
    if ($HAPDLLExists) {
        try {
            $data = Invoke-RestMethod -Method Get -Uri $HAPURL -UserAgent $MyUserAgent
            $DownVer = $data.versions[-1]
            $DriverVersion = (Get-Item "$ScriptsPath\ObsData\HtmlAgilityPack.dll").VersionInfo.FileVersion
            if ([System.Version]$DownVer -le [System.Version]$DriverVersion) {
                $Download = $False
            }
        }
        catch {
            $Download = $False
        }
    }
    if ($Download) {
        if (!$HAPDLLExists) {
            try {
                $data = Invoke-RestMethod -Method Get -Uri $HAPURL -UserAgent $MyUserAgent
                $DownVer = $data.versions[-1]
            }
            catch {
                return "Stop"
            }
        }
        $DownURL = "https://www.nuget.org/api/v2/package/HtmlAgilityPack/" + $DownVer
        $HAPFile = "htmlagilitypack.$DownVer.nupkg"
        (New-Object -TypeName System.Net.WebClient).DownloadFile($DownURL, "$ScriptsPath\$HAPFile")
        Rename-Item "$ScriptsPath\$HAPFile" "$ScriptsPath\$HAPFile.zip"
        [System.IO.Compression.ZipFile]::ExtractToDirectory("$ScriptsPath\$HAPFile.zip", "$ScriptsPath\TempFolder")
        Move-Item "$ScriptsPath\TempFolder\lib\netstandard2.0\HtmlAgilityPack.dll" "$ScriptsPath\ObsData" -Force -ea SilentlyContinue
        Remove-Item "$ScriptsPath\$HAPFile.zip" -Force
        Remove-Item "$ScriptsPath\TempFolder" -Recurse -Force
    }
    return "Kick"
}


# Main
if ($CheckPkg -eq "Yes") {
    switch (GetRqdPkg) {
            "Kick" {
                $Action = "Kick$($PingPong)"
                break
            }
            "Skip" {
                $Action = "Skip"
                break
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

$URL = "https://www.cwa.gov.tw/V8/C/W/Observe/MOD/24hr/$($StationId).html?T=" + (Get-Random -Maximum 99999999999)
$dataURL = "https://www.cwa.gov.tw/V8/C/W/OBS_Station.html?ID=$StationId"
if ($ConnectionOK -eq "NoConnection") {
    # 網路連線異常
    try {
        # 如果前一次資料正常則沿用, 但是把 $obsDataStatus/$P[1].P3 改為 網路連線異常
        $Header = 'P1','P2','P3','P4','P5','P6','P7','P8','P9','P10','P11','P12','P13','P14','P15','P16','P17','P18','P19','P20','P21','P22','P23','P24','P25','P26','P27','P28','P29'
        if ((($P = Import-Csv "$ObsDataPath\ObsData.txt" -Header $Header -Encoding Unicode).Count -ne $null) -and ($P[1].P3 -eq "正常")) {
            $P[1].P2 += "📶🈚"
            $P[1].P3 = "網路連線異常"
            $P[1].P29 = "NoConnection"
            if ($P[1].P11 -ne "") { $P[1].P11 = " " + $P[1].P11 }
            $obsLine = ""
            for ($i=1; $i -le 29; $i++) { $obsLine += $P[1]."P$($i)" + "," }
            Write-Host "Once"
            Write-Host $obsLine
            Exit
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
    $ApptTemp = ""
    $ApptTempTime = "-"
    $PoP = ""
    Write-Host "Skip"
    Write-Host $StationId","$StationName","$obsDataStatus","$obsDataRowCount","$mmdd","$HHMM","$tem","$weather","$weatherL1","$weatherL2","$w1","$w2","$w3","$visible","$hum","$pre","$rain","$sunlight"," -NoNewline
    Write-Host $SSTimeSunRize","$SSTimeSunSet","$DayOrNight","$TownId","$ApptTemp","$ApptTempTime","$PoP"," -NoNewline
    Write-Host 資料來源:中央氣象署全球資訊網","$dataURL"," -NoNewline
    Write-Host $ObsDataPath","$ConnectionOK","
    Exit
}

# ObsData
Add-Type -Path $ObsDataPath\HtmlAgilityPack.dll
$htmlDoc = New-Object HtmlAgilityPack.HtmlDocument

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
try {
    $htmlDoc.LoadHtml(($response = Invoke-WebRequest -UseBasicParsing -Uri $URL -UserAgent $MyUserAgent).Content)
    $StationName = "網路連線異常 " + $response.StatusCode
    if ($response.StatusCode -eq 200) {
        switch ($obsDataRowCount = $htmlDoc.DocumentNode.SelectNodes("/tr").count)
        {
            1       {   # 測站儀器故障, 儀器調校中
                        $obsDataStatus = $htmlDoc.DocumentNode.SelectSingleNode("/tr[1]").InnerText 
                        $StationName = $htmlDoc.DocumentNode.SelectSingleNode("/tr[1]").GetAttributes("data-cstname").Value + "🈚"
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
                        $StationName = $htmlDoc.DocumentNode.SelectSingleNode("/tr[1]").GetAttributes("data-cstname").Value
                        $htmlDoc.LoadHtml($htmlDoc.DocumentNode.SelectSingleNode("/tr[1]").innerHtml)
                        $htmlDoc.DocumentNode.SelectSingleNode("/th").InnerText -match '(?<mmdd>.*)\s(?<HHMM>.*)' | Out-Null
                        $mmdd = $Matches.mmdd
                        $HHMM = $Matches.HHMM
                        $tem = $htmlDoc.DocumentNode.SelectSingleNode("/td[1]/span[1]").InnerText
                        if ($tem -match '^-?\d.*$') {
                            $tem += "°"
                        } else {
                            $tem = $tem -replace '-|儀器(故障|調校)', '$1'
                        }
                        $w1 = $htmlDoc.DocumentNode.SelectSingleNode("/td[3]").InnerText
                        if ($w1 -match '^(?!儀器.*)') {
                            $w1 = ($w1 -replace '^(風向(不定)?$)?', ' $2') -replace '^ －$', ' -'  # Replace Unicode minus sign U+FF0D "－" ef bc 8d
                        } else {
                            $w1 = ""
                        }
                        $w2 = $htmlDoc.DocumentNode.SelectSingleNode("/td[4]/span[2]").InnerText -replace '^(儀器)(調校中)$', '$2'
                        $w3 = $htmlDoc.DocumentNode.SelectSingleNode("/td[5]/span[2]").InnerText -replace '^(儀器)(故障|調校)(.*)', '$2'
                        $visible = $htmlDoc.DocumentNode.SelectSingleNode("/td[6]").InnerText -replace '^(儀器)(故障|調校)(.*)', '$2'
                        $hum = ($htmlDoc.DocumentNode.SelectSingleNode("/td[7]").InnerText -replace '^(儀器)(故障|調校)(.*)', '$2') -replace '^(\d+)$', '$1%'
                        $pre = $htmlDoc.DocumentNode.SelectSingleNode("/td[8]").InnerText -replace '^(儀器)(調校中)(.*)', '$2'
                        $rain = $htmlDoc.DocumentNode.SelectSingleNode("/td[9]").InnerText -replace '^(儀器)(調校中)(.*)', '$2'
                        $sunlight = $htmlDoc.DocumentNode.SelectSingleNode("/td[10]").InnerText
                        try {
                            ($weather = $htmlDoc.DocumentNode.SelectSingleNode("/td[2]").ChildNodes.GetAttributes("title").Value) -match '^(?<weatherL1>晴|多雲|陰)?(?<weatherL2>.*)' | Out-Null
                            if ($null -eq $weather) {
                                $weather = "-"
                            } elseif ($null -eq $Matches.weatherL1) {
                                $weatherL1 = $weather
                                $weatherL2 = ""
                            } else {
                                $weatherL1 = $Matches.weatherL1
                                $weatherL2 = $Matches.weatherL2
                            }
                        }
                        catch {
                            $weather = "-"
                            $weatherL1 = ""
                            $weatherL2 = ""
                        }
                        break
                    }
        }
    }
} catch { $StationName = "網路連線異常 " + $response.StatusCode }

# ApptTemp and PoP
$ApptTempTime = "-"
$ApptTemp = ""
$Now = Get-Date
$NowMonthDay = $Now.ToString('MM/dd')
try {
    $ApptTempURL = "https://www.cwa.gov.tw/Data/js/GT/TableData_GT_T_$($CountyId).js?T=" + $($Now.ToString('yyyyMMddHH')) + "-$([math]::Floor($($Now.ToString('mm') / 10)))"
    $TableData = [Text.Encoding]::UTF8.GetString(($response = Invoke-WebRequest -Uri $ApptTempURL -UserAgent $MyUserAgent).RawContentStream.ToArray())
    if ($response.StatusCode -eq 200) {
        $ApptTempTime = ([regex]::Match($TableData, '(?s)GT_Time\s=\s(\{.*\});\nvar').captures.groups[1].value | ConvertFrom-Json).C -replace ".*(<br>)", ""
        $tempAppt = [regex]::Match($TableData, '(?s)GT\s=\s(\{.*\});').captures.groups[1].value | ConvertFrom-Json
        $ApptTemp = ($tempAppt.$($TownId)).C_AT + "°" -replace '(^-°$)', ''
    } else {
        $TownId = "體感溫度異常"
    }
} catch {
    $TownId = "體感溫度異常"
}
$PoP = ""
try {
    $PopURL = "https://www.cwa.gov.tw/V8/C/W/Town/MOD/3hr/$($TownId)_3hr_PC.html?T=" + $($Now.ToString('yyyyMMddHH')) + "-$([math]::Floor($($Now.ToString('mm') / 10)))"
    $htmlDoc.LoadHtml(($response = Invoke-WebRequest -UseBasicParsing -Uri $PopURL -UserAgent $MyUserAgent).Content)
    if ($response.StatusCode -eq 200) {
        $PoP = $htmlDoc.DocumentNode.SelectSingleNode('//*[contains(text(), "降雨機率")]/following::td[1]').InnerText
    }
} catch {}

# SSTime
$SSTimeMonthDay = $NowMonthDay
$SSTimeSunRize = "06:00"
$SSTimeSunSet = "18:00"
try {
    $SSTimeURL = "https://www.cwa.gov.tw/V8/C/W/County/MOD/SunMoon/$($CountyId)_SunMoon.html"
    $htmlDoc.LoadHtml(($response = Invoke-WebRequest -UseBasicParsing -Uri $SSTimeURL -UserAgent $MyUserAgent).Content)
    if ($response.StatusCode -eq 200) {
        $SSTimeMonthDay = $htmlDoc.DocumentNode.SelectSingleNode("/div[1]").InnerText
        $SSTimeSunRize = $htmlDoc.DocumentNode.SelectSingleNode("/div[2]/table/tbody/tr/td[1]").InnerText
        $SSTimeSunSet = $htmlDoc.DocumentNode.SelectSingleNode("/div[2]/table/tbody/tr/td[2]").InnerText
        if (("" -eq $SSTimeSunRize) -or ("-" -eq $SSTimeSunRize)) {
            $SSTimeMonthDay = $NowMonthDay
            $SSTimeSunRize = "06:00"
            $SSTimeSunSet = "18:00"
        }
    }
} catch {}
$SSTimeSunRize = Get-Date -Format "yyyy/$($SSTimeMonthDay) $($SSTimeSunRize)"
$SSTimeSunSet = Get-Date -Format "yyyy/$($SSTimeMonthDay) $($SSTimeSunSet)"

# DAY or NIGHT
if (($Now -ge [datetime]$SSTimeSunRize) -and (($Now - [datetime]$SSTimeSunSet).TotalMinutes -lt -15)) {
    $DayOrNight = 'DAY'
} else {
    $DayOrNight = 'NIGHT'
}

Write-Host $Action
Write-Host $StationId","$StationName","$obsDataStatus","$obsDataRowCount","$mmdd","$HHMM","$tem","$weather","$weatherL1","$weatherL2","$w1","$w2","$w3","$visible","$hum","$pre","$rain","$sunlight"," -NoNewline
Write-Host $SSTimeSunRize","$SSTimeSunSet","$DayOrNight","$TownId","$ApptTemp","$ApptTempTime","$PoP"," -NoNewline
Write-Host 資料來源:中央氣象署全球資訊網","$dataURL"," -NoNewline
Write-Host $ObsDataPath","$ConnectionOK","


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
# $ApptTemp        ->  [ObsData23ApptTemp]             ; 體感溫度
# $ApptTempTime    ->  [ObsData24ApptTempTime]         ; 體感溫度預報時間
# $PoP             ->  [ObsData25PoP]                  ; 降雨機率 (Probability of Precipitation)

# 資料來源:中央氣象署全球資訊網  ->  [ObsData26DataSource]   ; 資料來源聲明
# $dataURL                       ->  [ObsData27URL]          ; 資料來源URL
# $ObsDataPath                   ->  [ObsData28ObsDataPath]  ; ObsData路徑
# $ConnectionOK                  ->  [ObsData29ConnectionOK] ; KickStart ping (正常: ms, 斷線: NoConnection)
