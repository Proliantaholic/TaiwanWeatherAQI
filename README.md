## Taiwan Weather and AQI (Air Quality Index) 臺灣天氣和空氣品質指標
## Rainmeter Skin / Rainmeter 面板
> 顯示臺灣天氣資料和環保署空氣品質監測站的空氣品質指標(AQI, Air Quality Index)和PM2.5概況

本說明亦發表在: [proliantaholic.blogspot.com](https://proliantaholic.blogspot.com/2019/04/TaiwanWeatherAQI.html)

----
## 使用說明

### 安裝
* 下載TaiwanWeatherAQI_x.x.rmskin, 使用 Rainmeter 的 SkinInstaller.exe 安裝.

### 設定
指定天氣地點(WsiteName)和空氣品質監測站(AirSiteName)名稱:
* 在 Settings.txt 內設定. (在 TaiwanWeatherAQI\@RESOURCES\Settings 目錄內)
* 也可以在面板上按右鍵 -> 自訂面板動作 -> 指定天氣地點和空品測站(手動) (會打開 Settings.txt)
* 或是選擇自訂面板動作選單列出的天氣地點和空品測站.
* 天氣地點可參考: 即時天氣資料 https://opendata.epa.gov.tw/Data/Contents/ATM00698/ 地點欄位. 例如: 陽明山
* 測站名稱可參考: 空氣品質監測站基本資料 https://opendata.epa.gov.tw/Data/Contents/AQXSite/ 測站名稱欄位. 例如:中山

### 使用
用滑鼠左鍵雙擊不同區域可以帶出不同資訊:
* 天氣地點文字/溫度: 環境保護署 環境資源資料開放平台 即時天氣資料
* 衛星雲圖文字: 中央氣象局 衛星雲圖網頁
* 日出日沒時間/城市文字: 中央氣象局 日出日沒時間網頁 (根據空品測站所在縣市)
* AQI數字: 環境保護署 環境資源資料開放平台 空氣品質指標(AQI)
* AQI狀態圖案/文字/條狀圖: 空氣品質指標(AQI)與健康影響及活動建議說明
* 測站名稱文字: 該測站之即時影像還有位置 (Google Map)
* PM2.5/數字: 環境保護署 空氣品質監測網

----
## 資料來源與授權
* 空氣品質: 行政院環境保護署 環境資源資料開放平臺
* 天氣資料與日出日沒時間: 中央氣象局
* 授權方式: 依政府資料開放平臺使用規範 https://data.gov.tw/license/legacy

----
## Changelog
### Version 1.11 / 2019-04-xx
* 調整 介面調整
* 調整 資料更新頻率
* 新增 天氣圖示
* 新增 衛星雲圖文字/連結
* 新增 根據空品測站所在縣市: 顯示日出日沒時間, 判斷白天夜晚, 顯示不同背景和天氣圖示
* 新增 日出日沒時間/城市文字 連結 中央氣象局 日出日沒時間網頁
* 新增 夜晚背景圖
* 新增 空氣品質條狀圖
* 新增 自訂面板動作 天氣地點和空品測站選項
* 其他小調整

### Version 1.1 / 2019-04-03
* 更名為 TaiwanWeatherAQI
* 增加顯示天氣資訊
* 增加AQI測站名滑鼠左鍵雙擊顯示測站位置 (Google Map)

### Version 1.0 / 2019-04-02
* First release