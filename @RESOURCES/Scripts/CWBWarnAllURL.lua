function CWBWarnAllURL(code)
    local WarnAllLink = {
        ["PWS"] = "https://www.cwb.gov.tw/V8/C/P/PWS/PWS.html",
        ["EQ"] = "https://www.cwb.gov.tw/V8/C/E/index.html",
        ["TY_WIND"] = "https://www.cwb.gov.tw/V8/C/P/Typhoon/TY_WIND.html",
        ["TY_WARN"] = "https://www.cwb.gov.tw/V8/C/P/Typhoon/TY_WARN.html",
        ["TY_NEWS"] = "https://www.cwb.gov.tw/V8/C/P/Typhoon/TY_NEWS.html",
        ["FIFOWS"] = "https://www.cwb.gov.tw/V8/C/P/Warning/FIFOWS.html",
        ["W23"] = "https://www.cwb.gov.tw/V8/C/P/Warning/W23.html",
        ["W24"] = "https://www.cwb.gov.tw/V8/C/P/Warning/W24.html",
        ["W29"] = "https://www.cwb.gov.tw/V8/C/P/Warning/W29.html",
        ["W33"] = "https://www.cwb.gov.tw/V8/C/P/Warning/W33.html",
        ["W34"] = "https://www.cwb.gov.tw/V8/C/P/Warning/W34.html",
        ["W37"] = "https://www.cwb.gov.tw/V8/C/P/Warning/W37.html"
    }
    if (WarnAllLink[code] == nil) then
        return ""
    else
        return WarnAllLink[code]
    end
end
