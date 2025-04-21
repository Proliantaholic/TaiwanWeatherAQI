## Taiwan Weather and AQI (Air Quality Index) 臺灣天氣和空氣品質指標 [![TaiwanWeatherAQI](https://img.shields.io/github/v/release/Proliantaholic/TaiwanWeatherAQI?include_prereleases&style=social)](https://github.com/Proliantaholic/TaiwanWeatherAQI/releases/download/v3.24/TaiwanWeatherAQI_3.24.rmskin) [![TaiwanWeatherAQI](https://img.shields.io/github/license/Proliantaholic/TaiwanWeatherAQI?color=blue)](https://raw.githubusercontent.com/Proliantaholic/TaiwanWeatherAQI/master/LICENSE)
## Rainmeter Skin / Rainmeter 面板
> 顯示臺灣天氣資料和環境部空氣品質監測站的空氣品質指標(AQI, Air Quality Index)和PM<sub>2.5</sub>概況

#### 本說明亦發表在: [proliantaholic.blogspot.com](https://proliantaholic.blogspot.com/2019/04/TaiwanWeatherAQI.html)

![proliantaholic.blogspot.com](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhua0yLHNgc_mi2jBy7RqlZr8Ml52G75NTdn2cLrGX-fIBoGfs_UGaqO68YTbaCd1ytu2g7FILXZ77tHWGfKNh7SAkUnKEs15ZeUnlNgw-JubyGbs2GpzDU627sIjbVM28il55WOM_hykPF1x1fDMRt71z_-7FQ1GV8I2kbm-_W0sdHJBgU_t9-RJPo3pVA/s784/skin_v3.24_01.png)
![proliantaholic.blogspot.com](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhMpii0_n8PqmPkcve2KJwOsPiwiQpA0U9r4vyfuYLRBhDEV4Jt4wiSTlZu4eKPDzjyZrH7BYsGhRkKCwvJdEC0PRiFaW2Zs3ElfZOnH5c1wcu5pCwXQC2VUO7e40yu1AXUSjduZVuNat9jRGt9QkrmqiWO9RRQRNTO7SqQy2W-sD0PCdPDIn8yzLQgRnH4/s786/skin_v3.24_02.png)
----
## 使用說明

### 安裝
- 下載 [![TaiwanWeatherAQI](https://img.shields.io/github/v/release/Proliantaholic/TaiwanWeatherAQI?label=TaiwanWeatherAQI.rmskin&logoColor=brightgreen&style=social)](https://github.com/Proliantaholic/TaiwanWeatherAQI/releases/download/v3.24/TaiwanWeatherAQI_3.24.rmskin) 然後使用 [Rainmeter](https://www.rainmeter.net) 的 SkinInstaller.exe 安裝.

### 註冊申請API Key
**自Version 3.00起, AQI資料使用環境部資料開放平臺API v2取用資料, 需要申請API Key後才可使用**

關於相關授權之申請, 請參考:
- [環境部環境資源資料開放平臺會員註冊](https://data.moenv.gov.tw/api-term)
- [**取得API Key之程序**](https://data.moenv.gov.tw/paradigm)

### 設定
填入API Key(MoEnvApiKey): 設定MoEnvApiKey=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -> xxx...為您申請到的API Key
- 在 Settings.txt 內設定. (在 TaiwanWeatherAQI\@RESOURCES\Settings 目錄內)
- 在面板上按右鍵 -> 自訂面板動作 -> 指定 (會打開 Settings.txt)

指定天氣測站(ObsStationName)和空氣品質監測站(AirSiteName)名稱:
- 在 Settings.txt 內設定. (在 TaiwanWeatherAQI\@RESOURCES\Settings 目錄內)
- 在面板上按右鍵 -> 自訂面板動作 -> 指定天氣測站和空品測站(手動) (會打開 Settings.txt)
- 或是選擇自訂面板動作選單列出的天氣測站和空品測站.

也可以透過滑鼠右鍵單擊不同區域變更設定: (輸入後請按Enter確定變更)
- 天氣測站名稱文字: 天氣測站名稱(ObsStationName)
- 空品測站名稱文字: 空氣品質監測站名稱(AirSiteName)

天氣測站名稱可參考: [中央氣象署全球資訊網站 | 縣市測站列表](https://www.cwa.gov.tw/V8/C/W/OBS_County.html?ID=63) 找到你想要的測站, 網頁上方標題:XX測站觀測資料, XX即為測站名稱. 例如:臺北

空品測站名稱可參考: [空氣品質監測站基本資料](https://data.moenv.gov.tw/dataset/detail/AQX_P_07) 測站名稱欄位. 例如:中山

### 使用
用滑鼠左鍵雙擊不同區域可以帶出不同資訊:
- 天氣測站名稱文字: 中央氣象署全球資訊網站 鄉鎮天氣預報與天氣小叮嚀電子卡網頁 (根據天氣測站所在鄉鎮市區)
- 溫度: 中央氣象署全球資訊網站 測站觀測資料網頁 (根據所設定的天氣測站)
- 天氣圖資文字: 中央氣象署全球資訊網站 最新天氣圖資網頁
- 日出日沒時刻/城市文字: 中央氣象署全球資訊網站 縣市天氣預報網頁的日出日沒時刻欄位(根據天氣地點所在縣市)與天文資料下載網頁(日出日沒&曙暮光時刻表)
- 警示圖示⚠️: 中央氣象署全球資訊網站 警特報網頁
- AQI數字: 環境部 環境資源資料開放平臺 空氣品質指標(AQI), 空氣品質監測小時值資料(其它測項)
- AQI狀態圖案/文字/條狀圖: 空氣品質指標(AQI)與健康影響及活動建議說明
- 空品測站名稱文字: 該測站之影像還有位置 (Google Map)
- PM<sub>2.5</sub>/數字: 環境保護署 空氣品質監測網

將滑鼠指標移至不同區域可以顯示不同資訊:
- 天氣測站名稱文字:
    - 顯示天氣測站所在縣市的天氣預報, 天氣概況標題, 與資料更新時間
    - 顯示天氣測站所在鄉鎮市區的體感溫度預報, 3小時降雨機率預報
- 警示圖示⚠️: 顯示目前的警特報
- AQI數字或PM<sub>2.5</sub>數字: 顯示空氣污染指標物與資料更新時間 (第一行)
- AQI數字或PM<sub>2.5</sub>數字: 顯示空品測站的溫度濕度與資料更新時間 (第二行)

----
## 資料來源與授權
- [政府資料開放授權條款](https://data.gov.tw/license/)
- 天氣資料與日出日沒時刻, 縣市天氣概況: [中央氣象署全球資訊網站](https://www.cwa.gov.tw/V8/C/information.html)
- 空氣品質: [環境部 環境資源資料開放平臺](https://data.moenv.gov.tw/)
- 部分背景相片來自Pexels [(Pexels上的所有相片和影片均可免費使用)](https://www.pexels.com/zh-tw/license), 其餘背景相片為本人拍攝
- [Html Agility Pack](https://www.nuget.org/packages/HtmlAgilityPack)
- 天氣圖示原圖來自: [erikflowers/weather-icons](https://github.com/erikflowers/weather-icons), 由svg格式轉換及調整為png格式後使用

----
## Changelog
### Version 3.24 / 2025-04-21
- 更新 天氣圖示, 新天氣圖示原圖來自: [erikflowers/weather-icons](https://github.com/erikflowers/weather-icons)
- 調整 TaiwanWeatherAQI.ini
  - !Delay 改為 !Update
  - 調整 使用新天氣圖示
- 調整 GetObsData.ps1:
  - 清除舊code
- 調整 Settings.txt
- 更新 ObsStations202504.txt
### Version 3.23 / 2025-03-12
- 調整 TaiwanWeatherAQI.ini GetObsData.ps1
  - 合併 CWACTName.lua CWAWarnAllName.lua CWAWarnAllURL.lua 為 CWALua.lua
  - 調整天氣圖示, 天氣描述, 天氣背景顯示時機
- 調整 Settings.txt
- 更新 ObsStations202503.txt
### Version 3.22 / 2024-12-15
- 調整 Settings.txt
- 調整 GetObsData.ps1:
  - 調整為3小時降雨機率預報
- 更新 ObsStations202412.txt

### Version 3.21 / 2024-09-09
- 調整 Settings.txt
- 調整 GetObsData.ps1:
  - HtmlAgilityPack.dll版本判別方式從ProductVersion改為FileVersion
- 更新 ObsStations202409.txt

### Version 3.20 / 2024-04-07
- 調整 TaiwanWeatherAQI.ini, Settings.txt
- 改寫 GetObsData.ps1:
  - 天氣資料改用PowerShell透過Html Agility Pack去讀取分析中央氣象局全球資訊網站資料, 不再使用Selenium透過瀏覽器抓資料
- 更新 ObsStations202404.txt

### Version 3.15 / 2024-03-15
- 調整 TaiwanWeatherAQI.ini:
  - 調整 MeterCWAForecastMask 與 MeterCWAWarningMask 顯示的位置
  - 測站所在縣市名稱與測站區鄉鎮名稱改為查詢 CWACTName.lua
  - 配合 CWACTName.lua, 調整 ObsStationCountyName, MeterObsSSTime, MeterCWAForecastIssuedTime
  - 調整網路連線異常時的資料顯示 (如果前一次資料正常則沿用, 再來則顯示網路連線異常)
- 新增 CWACTName.lua
- 調整 GetObsData.ps1:
  - 新增WebDriver錯誤時logging
  - 抓取資料盡量改為使用 By CSS Selector
  - 移除查詢測站區鄉鎮名稱
- 更新 ObsStations202403.txt
  - 移除測站所在縣市名稱欄位
  - 更新重複測站名稱

### Version 3.14 / 2024-01-15
- 合併 GetWebDriver.ps1 GetObsData.ps1 為 GetObsData.ps1:
  - 改用function寫法, 精簡程式碼
  - 放棄支援下載Chrome 115以前的ChromeDriver
  - 調整解壓縮方式及解壓縮後檔案搬移方式
  - 調整網路連線異常時的資料顯示 (如果前一次資料正常則沿用)
  - 調整確認網頁下載完成的方式及等待時間
- 調整 TaiwanWeatherAQI.ini 配合新的 GetObsData.ps1
- 更新 ObsStations202401.txt

### Version 3.13 / 2023-09-05
- 配合「行政院環境保護署」於2023年8月22日改制升格為「環境部」:
  - 文字「環境保護署」調整為「環境部」
  - 網域名稱自 epa.gov.tw 調整為 moenv.gov.tw
  - 相關命名由EPA調整為MoEnv
    - TaiwanWeatherAQI.ini
    - Settings.txt
- 配合「中央氣象局」於2023年9月15日改制升格為「中央氣象署」:
  - 文字「中央氣象局」調整為「中央氣象署」
  - 網域名稱自 cwb.gov.tw 調整為 cwa.gov.tw
  - 相關命名由CWB調整為CWA
    - TaiwanWeatherAQI.ini
    - Settings.txt
    - CWBWarnAllURL.lua 調整為 CWAWarnAllURL.lua
    - CWBWarnAllName.lua 調整為 CWAWarnAllName.lua
    - GetObsData.ps1
- 更新 ObsStations202309.txt
- 調整 GetWebDriver.ps1:
  - 調整已經下載的msedgedriver.exe版本的判別方式
  - 調整下載.NET Standard 2.0版本的WebDriver.dll (Selenium 4.12.2起的版本)
  - 新增下載Json.NET
- 調整 GetObsData.ps1:
  - 調整使用.NET Standard 2.0版本的WebDriver.dll (Selenium 4.12.2起只有.NET Standard 2.0的版本)
  - 新增使用Json.NET: (因為.NET Standard 2.0的WebDriver.dll需要)
    - Newtonsoft.Json.dll, .NET Standard 2.0的版本
- 調整 TaiwanWeatherAQI.ini:
  - 調整AQI<10時數字顯示的位置

### Version 3.12 / 2023-08-05
- 更新 ObsStations202308.txt
- 調整 GetObsData.ps1:
  - 新增判別六小時降雨機率預報
- 調整 GetWebDriver.ps1:
  - 調整Chrome 115以後的ChromeDriver下載方式
  - 調整已經下載的Selenium版本的判別方式
- 調整 TaiwanWeatherAQI.ini:
  - 調整體感溫度相關顯示
  - 新增六小時降雨機率預報

### Version 3.11 / 2023-06-04
- 更新 ObsStations202306.txt
- 調整 GetObsData.ps1:
  - 新增判別天氣描述
  - 調整ObsData判斷跟轉換
  - 調整簡化SSTime判斷
- 調整 GetWebDriver.ps1:
  - Chrome, Edge版本的判別方式 (用正式版而非預覽版)
- 調整 TaiwanWeatherAQI.ini:
  - 空品測站影像URL判別
  - 天氣描述改為兩行 (雲量, 天氣現象)
  - 把ObsData判斷跟轉換移到GetObsData.ps1處理
  - 衛星雲圖文字改為天氣圖資, 雙擊後連結到最新天氣圖資網頁

### Version 3.10 / 2023-03-26
- 更新 ObsStations202303.txt
- 調整 Images檔案名稱大小寫
- 調整 GetObsData.ps1:
  - 呼叫參數: 增加TownId (體感溫度)
  - 回傳資料順序 (ObsData.txt格式)
  - 調整變數大小寫
  - AddArguments: 無痕模式
  - 網路連線異常時的處理: 移除Start-Sleep
  - 日出日沒時刻判斷方法 (改用match, 不用Selenium)
  - 新增體感溫度處理
- 調整 GetWebDriver.ps1:
  - 呼叫參數: 移除VerChrome, VerEdge
  - Firefox API rate limit exceeded時的處理 (改成抓網頁, 不用API)
  - 網路連線異常時的處理
- 調整 TaiwanWeatherAQI.ini:
  - Log
  - MeasureRun等的順序, 網路連線異常時的處理
  - 天氣狀況判別
  - 新增體感溫度預報

### Version 3.01 / 2022-11-02
- 更新 ObsStations202211.txt
- 調整 GetWebDriver.ps1: 調整Selenium WebDriver版本的判別方式

### Version 3.00 / 2022-07-10
- Version 3.00:
  - 因為AQI第1版API於2022年5月19日停止服務, AQI資料改使用第2版API取用資料 (需要到行政院環保署資料開放平臺註冊申請API Key)
  - 未設定AQI API Key則不會有AQI資料, 天氣資料仍會顯示
  - AQI API Key資訊請參考README.md的註冊申請API Key段落
- 調整 GetWebDriver.ps1:
  - 檢查已經下載的WebDriver/Selenium版本, 如果有更新的版本就下載新版
  - 改用System.Net.WebClient方式下載

### Version 2.10 / 2022-03-30
- 更新 ObsStations202203.txt: UTF-8-BOM -> UTF-8, 新增鄉鎮市區行政區域代碼
- 更新 Settings.txt: 空氣品質監測站基本資料連結
- 調整 天氣狀況對應: 有霾
- 調整 滑鼠左鍵雙擊天氣測站名稱文字: 天氣預報網頁, 由天氣測站所在縣市改為所在鄉鎮市區
- 調整 滑鼠左鍵雙擊AQI數字: 環境保護署 環境資源資料開放平台 空氣品質指標(AQI) 連結
- 新增 滑鼠指標移至AQI數字或PM<sub>2.5</sub>數字: 顯示空品測站的溫度濕度與資料更新時間 (第二行)
- 新增 支援空品測站行動測站名稱(有括號的測站名稱)

### Version 2.09 / 2022-02-19
- 更新 ObsStations202202.txt
- 調整 警特報連結 (TaiwanWeatherAQI.ini)

### Version 2.08 / 2021-10-15
- 更新 ObsStations202110.txt
- 調整 GetObsData.ps1: 配合Selenium 4.0.0, 移除UseChromium, 修改CreateChromiumService
- 調整 天氣狀況對應: 陰有閃電, 多雲有雷雨, 多雲大雷雨

### Version 2.07 / 2021-08-14
- 調整 警特報網頁顯示及連結 (TaiwanWeatherAQI.ini, CWBWarnAllName.lua, CWBWarnAllURL.lua)
- 調整 GetWebDriver.ps1: 調整Selenium WebDriver版本的判別方式

### Version 2.06 / 2021-08-03
- 更新 ObsStations202108.txt
- 調整 GetObsData.ps1: 配合Selenium 4.0.0-beta4, 修改FindElement方式
- 調整 天氣狀況對應: 晴有雷, 陰有雷, 多雲有雷
- 新增 W26對應URL: CWBWarnAllURL.lua
- 調整 AQI PM<sub>2.5</sub>數字顯示 0

### Version 2.05 / 2021-04-05
- 更新 ObsStations202104.txt
- 調整 GetObsData.ps1: 調整使用curl的Windows 10版本的判別方式, 新增判別下載Edge/Firefox WebDriver 32bit版本, 移除IE code
- 調整 GetObsData.ps1: 移除IE code
- 調整 天氣狀況對應: 有靄

### Version 2.04 / 2021-02-22
- 調整 GetObsData.ps1中天氣測站儀器故障時測站名稱的判別方式

### Version 2.03 / 2021-02-17
- 更新 ObsStations202102.txt
- 調整 GetWebDriver.ps1中Selenium下載版本的判別方式

### Version 2.02 / 2021-01-26
- 更新 ObsStations202101.txt
- 調整 GetWebDriver.ps1中Edge WebDriver下載版本的判別方式

### Version 2.01 / 2021-01-19
- 調整 GetObsData.ps1配合天氣資料格式變動
- 調整 警特報提示

### Version 2.0 / 2021-01-04
- Version 2.0: 天氣資料改用PowerShell透過WebDriver/Selenium去讀取中央氣象局全球資訊網站資料
- 如果出現亂碼: 在面板上按右鍵 -> 自訂面板動作 -> 選擇你有安裝的瀏覽器類別 (預設是Chrome)
- 天氣測站名稱: https://www.cwb.gov.tw/V8/C/W/OBS_County.html?ID=63 找到你想要的測站, 網頁上方標題:XX測站觀測資料, XX即為測站名稱. 例如:臺北
- 新增 根據天氣狀況顯示相對的桌布底圖
- 新增 滑鼠指標移至天氣測站名稱文字: 顯示天氣測站所在縣市的天氣預報
- 新增 警特報提示資訊: 滑鼠指標移至警示圖示⚠️, 顯示目前的警特報. 滑鼠左鍵雙擊圖示會開啟中央氣象局全球資訊網站相對的警特報網頁
- 調整 滑鼠左鍵雙擊溫度: 根據所設定的天氣測站, 開啟中央氣象局全球資訊網站 測站觀測資料網頁 

### Version 1.21 / 2020-11-08
- 新增 更新即時天氣資料連線逾時重試 (3次)
- 調整 空氣品質指標(AQI)資料來源為: 新版「環保署環境資料開放平臺」(data.epa.gov.tw) (試行版)
- 調整 AQI資料更新時間顯示格式 (去掉秒數)

### Version 1.20 / 2020-09-14
- 新增 即時天氣資料如果超過兩小時未有更新數據, 資料更新時間文字改以紅底白字顯示 (環境資源資料開放平台 即時天氣資料 有時會很久都沒更新)

### Version 1.19 / 2020-05-07
- 調整 滑鼠左鍵雙擊日出日沒時刻/城市文字: 中央氣象局全球資訊網站 縣市天氣預報網頁的日出日沒時刻欄位(根據天氣地點所在縣市)與天文資料下載網頁(日出日沒&曙暮光時刻表)
- 調整 滑鼠左鍵雙擊天氣地點文字: 中央氣象局全球資訊網站 天氣小叮嚀電子卡網頁連結

### Version 1.18 / 2020-05-06
- 調整 日出日沒時刻判斷方法

### Version 1.17 / 2020-05-05
- 新增 滑鼠指標移至天氣地點文字: 顯示天氣地點所在縣市天氣概況標題與資料更新時間
- 新增/調整 滑鼠左鍵雙擊天氣地點文字: 中央氣象局全球資訊網站 縣市天氣預報與天氣小叮嚀電子卡網頁 (根據天氣地點所在縣市)
- 新增 滑鼠指標移至AQI數字或PM<sub>2.5</sub>數字: 顯示空氣污染指標物與資料更新時間
- 調整 合併精簡scripts

### Version 1.16 / 2020-05-02
- 調整 天氣圖示顯示時機
- 調整 溫度顯示對齊方式
- 新增 滑鼠指標移至AQI數字或PM<sub>2.5</sub>數字: 顯示空氣污染指標物

### Version 1.15 / 2020-04-20
- 調整 改為根據天氣地點所在縣市(原為空品測站)的日出日沒時刻, 判斷白天夜晚
- 調整 日出日沒時刻顯示時機
- 調整 天氣圖示顯示時機
- 其他小調整

### Version 1.14 / 2020-04-16
- 調整 空氣品質條狀圖改為漸層

### Version 1.13 / 2020-04-10
- 新增 MIT授權條款
- 新增 WebParser UserAgent設定
- 修正 根據2020-04-07空氣品質監測網改版, 修正測站影像連結
- 其他小調整

### Version 1.12 / 2020-03-24
- 調整 Settings.txt
- 新增 天氣圖示對應: 多雲有雷聲, 多雲有雨, 多雲有閃電, 晴有雷聲, 有雨, 大雷雨
- 新增 滑鼠右鍵單擊變更設定: 天氣地點, 空品測站
- 修正 空氣品質指標(AQI)與健康影響及活動建議說明連結

### Version 1.11 / 2019-04-21
- 調整 介面調整
- 調整 資料更新頻率
- 新增 天氣圖示
- 新增 衛星雲圖文字/連結
- 新增 根據空品測站所在縣市: 顯示日出日沒時刻, 判斷白天夜晚, 顯示不同背景和天氣圖示
- 新增 日出日沒時刻/城市文字 連結 中央氣象局全球資訊網站 日出日沒時刻網頁
- 新增 夜晚背景圖
- 新增 空氣品質條狀圖
- 新增 自訂面板動作 天氣地點和空品測站選項
- 其他小調整

### Version 1.1 / 2019-04-03
- 更名為 TaiwanWeatherAQI
- 增加顯示天氣資訊
- 增加AQI測站名稱滑鼠左鍵雙擊顯示測站位置 (Google Maps)

### Version 1.0 / 2019-04-02
- First release