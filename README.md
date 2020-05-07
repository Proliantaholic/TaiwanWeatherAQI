## Taiwan Weather and AQI (Air Quality Index) 臺灣天氣和空氣品質指標 [![TaiwanWeatherAQI](https://img.shields.io/badge/release-v1.19-brightgreen.svg)](https://github.com/Proliantaholic/TaiwanWeatherAQI/raw/master/TaiwanWeatherAQI_1.19.rmskin) [![TaiwanWeatherAQI](https://img.shields.io/github/license/Proliantaholic/TaiwanWeatherAQI?color=blue)](https://raw.githubusercontent.com/Proliantaholic/TaiwanWeatherAQI/master/LICENSE)
## Rainmeter Skin / Rainmeter 面板
> 顯示臺灣天氣資料和環保署空氣品質監測站的空氣品質指標(AQI, Air Quality Index)和PM<sub>2.5</sub>概況

#### 本說明亦發表在: [proliantaholic.blogspot.com](https://proliantaholic.blogspot.com/2019/04/TaiwanWeatherAQI.html)

![proliantaholic.blogspot.com](https://tinyurl.com/y9nkasq9)
![proliantaholic.blogspot.com](https://tinyurl.com/y83zszun)

----
## 使用說明

### 安裝
* 下載 [![TaiwanWeatherAQI](https://img.shields.io/badge/TaiwanWeatherAQI.rmskin-v1.19-brightgreen.svg)](https://github.com/Proliantaholic/TaiwanWeatherAQI/raw/master/TaiwanWeatherAQI_1.19.rmskin) 然後使用 [Rainmeter](https://www.rainmeter.net) 的 SkinInstaller.exe 安裝.

### 設定
指定天氣地點(WsiteName)和空氣品質監測站(AirSiteName)名稱:
* 在 Settings.txt 內設定. (在 TaiwanWeatherAQI\@RESOURCES\Settings 目錄內)
* 在面板上按右鍵 -> 自訂面板動作 -> 指定天氣地點和空品測站(手動) (會打開 Settings.txt)
* 或是選擇自訂面板動作選單列出的天氣地點和空品測站.

也可以透過滑鼠右鍵單擊不同區域變更設定: (輸入後請按Enter確定變更)
* 天氣地點文字: 天氣地點(WsiteName)
* 空品測站文字: 空氣品質監測站(AirSiteName)名稱

天氣地點可參考: [即時天氣資料](https://opendata.epa.gov.tw/Data/Contents/ATM00698/) 地點欄位. 例如: 陽明山

測站名稱可參考: [空氣品質監測站基本資料](https://opendata.epa.gov.tw/Data/Contents/AQXSite/) 測站名稱欄位. 例如:中山

### 使用
用滑鼠左鍵雙擊不同區域可以帶出不同資訊:
* 天氣地點文字: 中央氣象局 縣市天氣預報與天氣小叮嚀電子卡網頁 (根據天氣地點所在縣市)
* 溫度: 環境保護署 環境資源資料開放平台 即時天氣資料
* 衛星雲圖文字: 中央氣象局 衛星雲圖網頁
* 日出日沒時刻/城市文字: 中央氣象局 縣市天氣預報網頁的日出日沒時刻欄位(根據天氣地點所在縣市)與天文資料下載網頁(日出日沒&曙暮光時刻表)
* AQI數字: 環境保護署 環境資源資料開放平台 空氣品質指標(AQI)
* AQI狀態圖案/文字/條狀圖: 空氣品質指標(AQI)與健康影響及活動建議說明
* 測站名稱文字: 該測站之影像還有位置 (Google Map)
* PM<sub>2.5</sub>/數字: 環境保護署 空氣品質監測網

將滑鼠指標移至不同區域可以顯示不同資訊:
* 天氣地點文字: 顯示天氣地點所在縣市天氣概況標題與資料更新時間
* AQI數字或PM<sub>2.5</sub>數字: 顯示空氣污染指標物與資料更新時間

----
## 資料來源與授權
* 空氣品質: 行政院環境保護署 [環境資源資料開放平臺](https://data.gov.tw/license/legacy)
* 天氣資料與日出日沒時刻: 中央氣象局
* 縣市天氣概況: 中央氣象局

----
## Changelog
### Version 1.19 / 2020-05-07
* 調整 日出日沒時刻/城市文字: 中央氣象局 日出日沒時刻網頁連結
* 調整 滑鼠左鍵雙擊天氣地點文字: 中央氣象局 天氣小叮嚀電子卡網頁連結

### Version 1.18 / 2020-05-06
* 調整 日出日沒時刻判斷方法

### Version 1.17 / 2020-05-05
* 新增 滑鼠指標移至天氣地點文字: 顯示天氣地點所在縣市天氣概況標題與資料更新時間
* 新增/調整 滑鼠左鍵雙擊天氣地點文字: 中央氣象局 縣市天氣預報與天氣小叮嚀電子卡網頁 (根據天氣地點所在縣市)
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
* 新增 日出日沒時刻/城市文字 連結 中央氣象局 日出日沒時刻網頁
* 新增 夜晚背景圖
* 新增 空氣品質條狀圖
* 新增 自訂面板動作 天氣地點和空品測站選項
* 其他小調整

### Version 1.1 / 2019-04-03
* 更名為 TaiwanWeatherAQI
* 增加顯示天氣資訊
* 增加AQI測站名滑鼠左鍵雙擊顯示測站位置 (Google Maps)

### Version 1.0 / 2019-04-02
* First release