function CWACTName(code)
    local CountyOrTownName = {
        ["10017"] = "基隆市",
        ["1001701"] = "中正區",
        ["1001702"] = "七堵區",
        ["1001703"] = "暖暖區",
        ["1001704"] = "仁愛區",
        ["1001705"] = "中山區",
        ["1001706"] = "安樂區",
        ["1001707"] = "信義區",
        ["63"] = "臺北市",
        ["6300100"] = "松山區",
        ["6300200"] = "信義區",
        ["6300300"] = "大安區",
        ["6300400"] = "中山區",
        ["6300500"] = "中正區",
        ["6300600"] = "大同區",
        ["6300700"] = "萬華區",
        ["6300800"] = "文山區",
        ["6300900"] = "南港區",
        ["6301000"] = "內湖區",
        ["6301100"] = "士林區",
        ["6301200"] = "北投區",
        ["65"] = "新北市",
        ["6500100"] = "板橋區",
        ["6500200"] = "三重區",
        ["6500300"] = "中和區",
        ["6500400"] = "永和區",
        ["6500500"] = "新莊區",
        ["6500600"] = "新店區",
        ["6500700"] = "樹林區",
        ["6500800"] = "鶯歌區",
        ["6500900"] = "三峽區",
        ["6501000"] = "淡水區",
        ["6501100"] = "汐止區",
        ["6501200"] = "瑞芳區",
        ["6501300"] = "土城區",
        ["6501400"] = "蘆洲區",
        ["6501500"] = "五股區",
        ["6501600"] = "泰山區",
        ["6501700"] = "林口區",
        ["6501800"] = "深坑區",
        ["6501900"] = "石碇區",
        ["6502000"] = "坪林區",
        ["6502100"] = "三芝區",
        ["6502200"] = "石門區",
        ["6502300"] = "八里區",
        ["6502400"] = "平溪區",
        ["6502500"] = "雙溪區",
        ["6502600"] = "貢寮區",
        ["6502700"] = "金山區",
        ["6502800"] = "萬里區",
        ["6502900"] = "烏來區",
        ["68"] = "桃園市",
        ["6800100"] = "桃園區",
        ["6800200"] = "中壢區",
        ["6800300"] = "大溪區",
        ["6800400"] = "楊梅區",
        ["6800500"] = "蘆竹區",
        ["6800600"] = "大園區",
        ["6800700"] = "龜山區",
        ["6800800"] = "八德區",
        ["6800900"] = "龍潭區",
        ["6801000"] = "平鎮區",
        ["6801100"] = "新屋區",
        ["6801200"] = "觀音區",
        ["6801300"] = "復興區",
        ["10018"] = "新竹市",
        ["1001801"] = "東區",
        ["1001802"] = "北區",
        ["1001803"] = "香山區",
        ["10004"] = "新竹縣",
        ["1000401"] = "竹北市",
        ["1000402"] = "竹東鎮",
        ["1000403"] = "新埔鎮",
        ["1000404"] = "關西鎮",
        ["1000405"] = "湖口鄉",
        ["1000406"] = "新豐鄉",
        ["1000407"] = "芎林鄉",
        ["1000408"] = "橫山鄉",
        ["1000409"] = "北埔鄉",
        ["1000410"] = "寶山鄉",
        ["1000411"] = "峨眉鄉",
        ["1000412"] = "尖石鄉",
        ["1000413"] = "五峰鄉",
        ["10005"] = "苗栗縣",
        ["1000501"] = "苗栗市",
        ["1000502"] = "苑裡鎮",
        ["1000503"] = "通霄鎮",
        ["1000504"] = "竹南鎮",
        ["1000505"] = "頭份市",
        ["1000506"] = "後龍鎮",
        ["1000507"] = "卓蘭鎮",
        ["1000508"] = "大湖鄉",
        ["1000509"] = "公館鄉",
        ["1000510"] = "銅鑼鄉",
        ["1000511"] = "南庄鄉",
        ["1000512"] = "頭屋鄉",
        ["1000513"] = "三義鄉",
        ["1000514"] = "西湖鄉",
        ["1000515"] = "造橋鄉",
        ["1000516"] = "三灣鄉",
        ["1000517"] = "獅潭鄉",
        ["1000518"] = "泰安鄉",
        ["66"] = "臺中市",
        ["6600100"] = "中區",
        ["6600200"] = "東區",
        ["6600300"] = "南區",
        ["6600400"] = "西區",
        ["6600500"] = "北區",
        ["6600600"] = "西屯區",
        ["6600700"] = "南屯區",
        ["6600800"] = "北屯區",
        ["6600900"] = "豐原區",
        ["6601000"] = "東勢區",
        ["6601100"] = "大甲區",
        ["6601200"] = "清水區",
        ["6601300"] = "沙鹿區",
        ["6601400"] = "梧棲區",
        ["6601500"] = "后里區",
        ["6601600"] = "神岡區",
        ["6601700"] = "潭子區",
        ["6601800"] = "大雅區",
        ["6601900"] = "新社區",
        ["6602000"] = "石岡區",
        ["6602100"] = "外埔區",
        ["6602200"] = "大安區",
        ["6602300"] = "烏日區",
        ["6602400"] = "大肚區",
        ["6602500"] = "龍井區",
        ["6602600"] = "霧峰區",
        ["6602700"] = "太平區",
        ["6602800"] = "大里區",
        ["6602900"] = "和平區",
        ["10007"] = "彰化縣",
        ["1000701"] = "彰化市",
        ["1000702"] = "鹿港鎮",
        ["1000703"] = "和美鎮",
        ["1000704"] = "線西鄉",
        ["1000705"] = "伸港鄉",
        ["1000706"] = "福興鄉",
        ["1000707"] = "秀水鄉",
        ["1000708"] = "花壇鄉",
        ["1000709"] = "芬園鄉",
        ["1000710"] = "員林市",
        ["1000711"] = "溪湖鎮",
        ["1000712"] = "田中鎮",
        ["1000713"] = "大村鄉",
        ["1000714"] = "埔鹽鄉",
        ["1000715"] = "埔心鄉",
        ["1000716"] = "永靖鄉",
        ["1000717"] = "社頭鄉",
        ["1000718"] = "二水鄉",
        ["1000719"] = "北斗鎮",
        ["1000720"] = "二林鎮",
        ["1000721"] = "田尾鄉",
        ["1000722"] = "埤頭鄉",
        ["1000723"] = "芳苑鄉",
        ["1000724"] = "大城鄉",
        ["1000725"] = "竹塘鄉",
        ["1000726"] = "溪州鄉",
        ["10008"] = "南投縣",
        ["1000801"] = "南投市",
        ["1000802"] = "埔里鎮",
        ["1000803"] = "草屯鎮",
        ["1000804"] = "竹山鎮",
        ["1000805"] = "集集鎮",
        ["1000806"] = "名間鄉",
        ["1000807"] = "鹿谷鄉",
        ["1000808"] = "中寮鄉",
        ["1000809"] = "魚池鄉",
        ["1000810"] = "國姓鄉",
        ["1000811"] = "水里鄉",
        ["1000812"] = "信義鄉",
        ["1000813"] = "仁愛鄉",
        ["10009"] = "雲林縣",
        ["1000901"] = "斗六市",
        ["1000902"] = "斗南鎮",
        ["1000903"] = "虎尾鎮",
        ["1000904"] = "西螺鎮",
        ["1000905"] = "土庫鎮",
        ["1000906"] = "北港鎮",
        ["1000907"] = "古坑鄉",
        ["1000908"] = "大埤鄉",
        ["1000909"] = "莿桐鄉",
        ["1000910"] = "林內鄉",
        ["1000911"] = "二崙鄉",
        ["1000912"] = "崙背鄉",
        ["1000913"] = "麥寮鄉",
        ["1000914"] = "東勢鄉",
        ["1000915"] = "褒忠鄉",
        ["1000916"] = "臺西鄉",
        ["1000917"] = "元長鄉",
        ["1000918"] = "四湖鄉",
        ["1000919"] = "口湖鄉",
        ["1000920"] = "水林鄉",
        ["10020"] = "嘉義市",
        ["1002001"] = "東區",
        ["1002002"] = "西區",
        ["10010"] = "嘉義縣",
        ["1001001"] = "太保市",
        ["1001002"] = "朴子市",
        ["1001003"] = "布袋鎮",
        ["1001004"] = "大林鎮",
        ["1001005"] = "民雄鄉",
        ["1001006"] = "溪口鄉",
        ["1001007"] = "新港鄉",
        ["1001008"] = "六腳鄉",
        ["1001009"] = "東石鄉",
        ["1001010"] = "義竹鄉",
        ["1001011"] = "鹿草鄉",
        ["1001012"] = "水上鄉",
        ["1001013"] = "中埔鄉",
        ["1001014"] = "竹崎鄉",
        ["1001015"] = "梅山鄉",
        ["1001016"] = "番路鄉",
        ["1001017"] = "大埔鄉",
        ["1001018"] = "阿里山鄉",
        ["67"] = "臺南市",
        ["6700100"] = "新營區",
        ["6700200"] = "鹽水區",
        ["6700300"] = "白河區",
        ["6700400"] = "柳營區",
        ["6700500"] = "後壁區",
        ["6700600"] = "東山區",
        ["6700700"] = "麻豆區",
        ["6700800"] = "下營區",
        ["6700900"] = "六甲區",
        ["6701000"] = "官田區",
        ["6701100"] = "大內區",
        ["6701200"] = "佳里區",
        ["6701300"] = "學甲區",
        ["6701400"] = "西港區",
        ["6701500"] = "七股區",
        ["6701600"] = "將軍區",
        ["6701700"] = "北門區",
        ["6701800"] = "新化區",
        ["6701900"] = "善化區",
        ["6702000"] = "新市區",
        ["6702100"] = "安定區",
        ["6702200"] = "山上區",
        ["6702300"] = "玉井區",
        ["6702400"] = "楠西區",
        ["6702500"] = "南化區",
        ["6702600"] = "左鎮區",
        ["6702700"] = "仁德區",
        ["6702800"] = "歸仁區",
        ["6702900"] = "關廟區",
        ["6703000"] = "龍崎區",
        ["6703100"] = "永康區",
        ["6703200"] = "東區",
        ["6703300"] = "南區",
        ["6703400"] = "北區",
        ["6703500"] = "安南區",
        ["6703600"] = "安平區",
        ["6703700"] = "中西區",
        ["64"] = "高雄市",
        ["6400100"] = "鹽埕區",
        ["6400200"] = "鼓山區",
        ["6400300"] = "左營區",
        ["6400400"] = "楠梓區",
        ["6400500"] = "三民區",
        ["6400600"] = "新興區",
        ["6400700"] = "前金區",
        ["6400800"] = "苓雅區",
        ["6400900"] = "前鎮區",
        ["6401000"] = "旗津區",
        ["6401100"] = "小港區",
        ["6401200"] = "鳳山區",
        ["6401300"] = "林園區",
        ["6401400"] = "大寮區",
        ["6401500"] = "大樹區",
        ["6401600"] = "大社區",
        ["6401700"] = "仁武區",
        ["6401800"] = "鳥松區",
        ["6401900"] = "岡山區",
        ["6402000"] = "橋頭區",
        ["6402100"] = "燕巢區",
        ["6402200"] = "田寮區",
        ["6402300"] = "阿蓮區",
        ["6402400"] = "路竹區",
        ["6402500"] = "湖內區",
        ["6402600"] = "茄萣區",
        ["6402700"] = "永安區",
        ["6402800"] = "彌陀區",
        ["6402900"] = "梓官區",
        ["6403000"] = "旗山區",
        ["6403100"] = "美濃區",
        ["6403200"] = "六龜區",
        ["6403300"] = "甲仙區",
        ["6403400"] = "杉林區",
        ["6403500"] = "內門區",
        ["6403600"] = "茂林區",
        ["6403700"] = "桃源區",
        ["6403800"] = "那瑪夏區",
        ["10013"] = "屏東縣",
        ["1001301"] = "屏東市",
        ["1001302"] = "潮州鎮",
        ["1001303"] = "東港鎮",
        ["1001304"] = "恆春鎮",
        ["1001305"] = "萬丹鄉",
        ["1001306"] = "長治鄉",
        ["1001307"] = "麟洛鄉",
        ["1001308"] = "九如鄉",
        ["1001309"] = "里港鄉",
        ["1001310"] = "鹽埔鄉",
        ["1001311"] = "高樹鄉",
        ["1001312"] = "萬巒鄉",
        ["1001313"] = "內埔鄉",
        ["1001314"] = "竹田鄉",
        ["1001315"] = "新埤鄉",
        ["1001316"] = "枋寮鄉",
        ["1001317"] = "新園鄉",
        ["1001318"] = "崁頂鄉",
        ["1001319"] = "林邊鄉",
        ["1001320"] = "南州鄉",
        ["1001321"] = "佳冬鄉",
        ["1001322"] = "琉球鄉",
        ["1001323"] = "車城鄉",
        ["1001324"] = "滿州鄉",
        ["1001325"] = "枋山鄉",
        ["1001326"] = "三地門鄉",
        ["1001327"] = "霧臺鄉",
        ["1001328"] = "瑪家鄉",
        ["1001329"] = "泰武鄉",
        ["1001330"] = "來義鄉",
        ["1001331"] = "春日鄉",
        ["1001332"] = "獅子鄉",
        ["1001333"] = "牡丹鄉",
        ["10002"] = "宜蘭縣",
        ["1000201"] = "宜蘭市",
        ["1000202"] = "羅東鎮",
        ["1000203"] = "蘇澳鎮",
        ["1000204"] = "頭城鎮",
        ["1000205"] = "礁溪鄉",
        ["1000206"] = "壯圍鄉",
        ["1000207"] = "員山鄉",
        ["1000208"] = "冬山鄉",
        ["1000209"] = "五結鄉",
        ["1000210"] = "三星鄉",
        ["1000211"] = "大同鄉",
        ["1000212"] = "南澳鄉",
        ["10015"] = "花蓮縣",
        ["1001501"] = "花蓮市",
        ["1001502"] = "鳳林鎮",
        ["1001503"] = "玉里鎮",
        ["1001504"] = "新城鄉",
        ["1001505"] = "吉安鄉",
        ["1001506"] = "壽豐鄉",
        ["1001507"] = "光復鄉",
        ["1001508"] = "豐濱鄉",
        ["1001509"] = "瑞穗鄉",
        ["1001510"] = "富里鄉",
        ["1001511"] = "秀林鄉",
        ["1001512"] = "萬榮鄉",
        ["1001513"] = "卓溪鄉",
        ["10014"] = "臺東縣",
        ["1001401"] = "臺東市",
        ["1001402"] = "成功鎮",
        ["1001403"] = "關山鎮",
        ["1001404"] = "卑南鄉",
        ["1001405"] = "鹿野鄉",
        ["1001406"] = "池上鄉",
        ["1001407"] = "東河鄉",
        ["1001408"] = "長濱鄉",
        ["1001409"] = "太麻里鄉",
        ["1001410"] = "大武鄉",
        ["1001411"] = "綠島鄉",
        ["1001412"] = "海端鄉",
        ["1001413"] = "延平鄉",
        ["1001414"] = "金峰鄉",
        ["1001415"] = "達仁鄉",
        ["1001416"] = "蘭嶼鄉",
        ["10016"] = "澎湖縣",
        ["1001601"] = "馬公市",
        ["1001602"] = "湖西鄉",
        ["1001603"] = "白沙鄉",
        ["1001604"] = "西嶼鄉",
        ["1001605"] = "望安鄉",
        ["1001606"] = "七美鄉",
        ["09020"] = "金門縣",
        ["0902001"] = "金城鎮",
        ["0902002"] = "金沙鎮",
        ["0902003"] = "金湖鎮",
        ["0902004"] = "金寧鄉",
        ["0902005"] = "烈嶼鄉",
        ["0902006"] = "烏坵鄉",
        ["09007"] = "連江縣",
        ["0900701"] = "南竿鄉",
        ["0900702"] = "北竿鄉",
        ["0900703"] = "莒光鄉",
        ["0900704"] = "東引鄉"
    }
    if (CountyOrTownName[code] == nil) then
        return ""
    else
        return CountyOrTownName[code]
    end
end
