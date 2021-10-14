## Taiwan Weather and AQI (Air Quality Index) 臺灣天氣和空氣品質指標 [![TaiwanWeatherAQI](https://img.shields.io/github/v/release/Proliantaholic/TaiwanWeatherAQI?include_prereleases&style=social)](https://github.com/Proliantaholic/TaiwanWeatherAQI/releases/download/v2.08/TaiwanWeatherAQI_2.08.rmskin) [![TaiwanWeatherAQI](https://img.shields.io/github/license/Proliantaholic/TaiwanWeatherAQI?color=blue)](https://raw.githubusercontent.com/Proliantaholic/TaiwanWeatherAQI/master/LICENSE)
## Rainmeter Skin / Rainmeter 面板
> 顯示臺灣天氣資料和環保署空氣品質監測站的空氣品質指標(AQI, Air Quality Index)和PM<sub>2.5</sub>概況

#### 本說明亦發表在: [proliantaholic.blogspot.com](https://proliantaholic.blogspot.com/2019/04/TaiwanWeatherAQI.html)

![proliantaholic.blogspot.com](https://tinyurl.com/ycd8kmdc)
![proliantaholic.blogspot.com](https://tinyurl.com/y7gzat4g)

----
## 使用說明

### 安裝
* 下載 [![TaiwanWeatherAQI](https://img.shields.io/github/v/release/Proliantaholic/TaiwanWeatherAQI?label=TaiwanWeatherAQI.rmskin&logoColor=brightgreen&style=social)](https://github.com/Proliantaholic/TaiwanWeatherAQI/releases/download/v2.08/TaiwanWeatherAQI_2.08.rmskin) 然後使用 [Rainmeter](https://www.rainmeter.net) 的 SkinInstaller.exe 安裝.

### 設定
指定天氣測站(ObsStationName)和空氣品質監測站(AirSiteName)名稱:
* 在 Settings.txt 內設定. (在 TaiwanWeatherAQI\@RESOURCES\Settings 目錄內)
* 在面板上按右鍵 -> 自訂面板動作 -> 指定天氣測站和空品測站(手動) (會打開 Settings.txt)
* 或是選擇自訂面板動作選單列出的天氣測站和空品測站.

也可以透過滑鼠右鍵單擊不同區域變更設定: (輸入後請按Enter確定變更)
* 天氣測站名稱文字: 天氣測站名稱(ObsStationName)
* 空品測站名稱文字: 空氣品質監測站名稱(AirSiteName)

天氣測站名稱可參考: [中央氣象局全球資訊網站 | 縣市測站列表](https://www.cwb.gov.tw/V8/C/W/OBS_County.html?ID=63) 找到你想要的測站, 網頁上方標題:XX測站觀測資料, XX即為測站名稱. 例如:臺北

空品測站名稱可參考: [空氣品質監測站基本資料](https://data.epa.gov.tw/dataset/aqx_p_07/resource/fb92f773-27ca-470a-af04-6000397f7a4e) 測站名稱欄位. 例如:中山

設定瀏覽器類別: (Chrome, Edge, Firefox)
* Version 2.0起使用瀏覽器讀取中央氣象局全球資訊網站天氣資料
* 在 Settings.txt 內設定. (在 TaiwanWeatherAQI\@RESOURCES\Settings 目錄內)
* 或是在面板上按右鍵 -> 自訂面板動作 -> 選擇你有安裝的瀏覽器類別 (預設是Chrome)

### 使用
用滑鼠左鍵雙擊不同區域可以帶出不同資訊:
* 天氣測站名稱文字: 中央氣象局全球資訊網站 縣市天氣預報與天氣小叮嚀電子卡網頁 (根據天氣測站所在縣市)
* 溫度: 中央氣象局全球資訊網站 測站觀測資料網頁 (根據所設定的天氣測站)
* 衛星雲圖文字: 中央氣象局全球資訊網站 衛星雲圖網頁
* 日出日沒時刻/城市文字: 中央氣象局全球資訊網站 縣市天氣預報網頁的日出日沒時刻欄位(根據天氣地點所在縣市)與天文資料下載網頁(日出日沒&曙暮光時刻表)
* 警示圖示⚠️: 中央氣象局全球資訊網站 警特報網頁
* AQI數字: 環境保護署 環境資源資料開放平台 空氣品質指標(AQI)
* AQI狀態圖案/文字/條狀圖: 空氣品質指標(AQI)與健康影響及活動建議說明
* 空品測站名稱文字: 該測站之影像還有位置 (Google Map)
* PM<sub>2.5</sub>/數字: 環境保護署 空氣品質監測網

將滑鼠指標移至不同區域可以顯示不同資訊:
* 天氣測站名稱文字: 顯示天氣測站所在縣市的天氣預報, 天氣概況標題, 與資料更新時間
* 警示圖示⚠️: 顯示目前的警特報
* AQI數字或PM<sub>2.5</sub>數字: 顯示空氣污染指標物與資料更新時間

----
## 資料來源與授權
* [政府資料開放授權條款](https://data.gov.tw/license/)
* 天氣資料與日出日沒時刻, 縣市天氣概況: [中央氣象局全球資訊網站](https://www.cwb.gov.tw/V8/C/information.html)
* 空氣品質: [環保署環境資料開放平臺](https://data.epa.gov.tw/)
* 部分桌布底圖相片來自Pexels [(Pexels上的所有相片和影片均可免費使用)](https://www.pexels.com/zh-tw/license/), 其餘桌布相片為本人拍攝
* [Google Chrome driver](https://chromedriver.storage.googleapis.com)
* [Microsoft Edge driver](https://msedgedriver.azureedge.net)
* [Firefox driver](https://api.github.com/repos/mozilla/geckodriver/releases)
* [Selenium WebDriver](https://www.nuget.org/packages/Selenium.WebDriver)

----
## Changelog
### Version 2.08 / 2021-10-15
* 更新 ObsStations202110.txt
* 調整 GetObsData.ps1: 配合Selenium 4.0.0, 移除UseChromium, 修改CreateChromiumService
* 調整 天氣狀況對應: 陰有閃電, 多雲有雷雨, 多雲大雷雨

### Version 2.07 / 2021-08-14
* 調整 警特報網頁顯示及連結 (TaiwanWeatherAQI.ini, CWBWarnAllName.lua, CWBWarnAllURL.lua)
* 調整 GetWebDriver.ps1: 調整Selenium WebDriver版本的判別方式

### Version 2.06 / 2021-08-03
* 更新 ObsStations202108.txt
* 調整 GetObsData.ps1: 配合Selenium 4.0.0-beta4, 修改FindElement方式
* 調整 天氣狀況對應: 晴有雷, 陰有雷, 多雲有雷
* 新增 W26對應URL: CWBWarnAllURL.lua
* 調整 AQI PM<sub>2.5</sub>數字顯示 0

### Version 2.05 / 2021-04-05
* 更新 ObsStations202104.txt
* 調整 GetObsData.ps1: 調整使用curl的Windows 10版本的判別方式, 新增判別下載Edge/Firefox WebDriver 32bit版本, 移除IE code
* 調整 GetObsData.ps1: 移除IE code
* 調整 天氣狀況對應: 有靄

### Version 2.04 / 2021-02-22
* 調整 GetObsData.ps1中天氣測站儀器故障時測站名稱的判別方式

### Version 2.03 / 2021-02-17
* 更新 ObsStations202102.txt
* 調整 GetWebDriver.ps1中Selenium下載版本的判別方式

### Version 2.02 / 2021-01-26
* 更新 ObsStations202101.txt
* 調整 GetWebDriver.ps1中Edge WebDriver下載版本的判別方式

### Version 2.01 / 2021-01-19
* 調整 GetObsData.ps1配合天氣資料格式變動
* 調整 警特報提示

### Version 2.0 / 2021-01-04
* Version 2.0: 天氣資料改用PowerShell透過WebDriver/Selenium去讀取中央氣象局全球資訊網站資料
* 如果出現亂碼: 在面板上按右鍵 -> 自訂面板動作 -> 選擇你有安裝的瀏覽器類別 (預設是Chrome)
* 天氣測站名稱: https://www.cwb.gov.tw/V8/C/W/OBS_County.html?ID=63 找到你想要的測站, 網頁上方標題:XX測站觀測資料, XX即為測站名稱. 例如:臺北
* 新增 根據天氣狀況顯示相對的桌布底圖
* 新增 滑鼠指標移至天氣測站名稱文字: 顯示天氣測站所在縣市的天氣預報
* 新增 警特報提示資訊: 滑鼠指標移至警示圖示⚠️, 顯示目前的警特報. 滑鼠左鍵雙擊圖示會開啟中央氣象局全球資訊網站相對的警特報網頁
* 調整 滑鼠左鍵雙擊溫度: 根據所設定的天氣測站, 開啟中央氣象局全球資訊網站 測站觀測資料網頁 

### Version 1.21 / 2020-11-08
* 新增 更新即時天氣資料連線逾時重試 (3次)
* 調整 空氣品質指標(AQI)資料來源為: 新版「環保署環境資料開放平臺」(data.epa.gov.tw) (試行版)
* 調整 AQI資料更新時間顯示格式 (去掉秒數)

### Version 1.20 / 2020-09-14
* 新增 即時天氣資料如果超過兩小時未有更新數據, 資料更新時間文字改以紅底白字顯示 (環境資源資料開放平台 即時天氣資料 有時會很久都沒更新)

### Version 1.19 / 2020-05-07
* 調整 滑鼠左鍵雙擊日出日沒時刻/城市文字: 中央氣象局全球資訊網站 縣市天氣預報網頁的日出日沒時刻欄位(根據天氣地點所在縣市)與天文資料下載網頁(日出日沒&曙暮光時刻表)
* 調整 滑鼠左鍵雙擊天氣地點文字: 中央氣象局全球資訊網站 天氣小叮嚀電子卡網頁連結

### Version 1.18 / 2020-05-06
* 調整 日出日沒時刻判斷方法

### Version 1.17 / 2020-05-05
* 新增 滑鼠指標移至天氣地點文字: 顯示天氣地點所在縣市天氣概況標題與資料更新時間
* 新增/調整 滑鼠左鍵雙擊天氣地點文字: 中央氣象局全球資訊網站 縣市天氣預報與天氣小叮嚀電子卡網頁 (根據天氣地點所在縣市)
* 新增 滑鼠指標移至AQI數字或PM<sub>2.5</sub>數字: 顯示空氣污染指標物與資料更新時間
* 調整 合併精簡scripts

### Version 1.16 / 2020-05-02
* 調整 天氣圖示顯示時機
* 調整 溫度顯示對齊方式
* 新增 滑鼠指標移至AQI數字或PM<sub>2.5</sub>數字: 顯示空氣污染指標物

### Version 1.15 / 2020-04-20
* 調整 改為根據天氣地點所在縣市(原為空品測站)的日出日沒時刻, 判斷白天夜晚
* 調整 日出日沒時刻顯示時機
* 調整 天氣圖示顯示時機
* 其他小調整

### Version 1.14 / 2020-04-16
* 調整 空氣品質條狀圖改為漸層

### Version 1.13 / 2020-04-10
* 新增 MIT授權條款
* 新增 WebParser UserAgent設定
* 修正 根據2020-04-07空氣品質監測網改版, 修正測站影像連結
* 其他小調整

### Version 1.12 / 2020-03-24
* 調整 Settings.txt
* 新增 天氣圖示對應: 多雲有雷聲, 多雲有雨, 多雲有閃電, 晴有雷聲, 有雨, 大雷雨
* 新增 滑鼠右鍵單擊變更設定: 天氣地點, 空品測站
* 修正 空氣品質指標(AQI)與健康影響及活動建議說明連結

### Version 1.11 / 2019-04-21
* 調整 介面調整
* 調整 資料更新頻率
* 新增 天氣圖示
* 新增 衛星雲圖文字/連結
* 新增 根據空品測站所在縣市: 顯示日出日沒時刻, 判斷白天夜晚, 顯示不同背景和天氣圖示
* 新增 日出日沒時刻/城市文字 連結 中央氣象局全球資訊網站 日出日沒時刻網頁
* 新增 夜晚背景圖
* 新增 空氣品質條狀圖
* 新增 自訂面板動作 天氣地點和空品測站選項
* 其他小調整

### Version 1.1 / 2019-04-03
* 更名為 TaiwanWeatherAQI
* 增加顯示天氣資訊
* 增加AQI測站名稱滑鼠左鍵雙擊顯示測站位置 (Google Maps)

### Version 1.0 / 2019-04-02
* First release