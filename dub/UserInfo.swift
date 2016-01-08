//
//  UserInfo.swift
//  dub
//
//  Created by cuimingqiang on 15/12/24.
//  Copyright © 2015年 cuimingqiang. All rights reserved.
//

import UIKit
import SwiftyJSON
/*
{
data =     {
area = 3301;
"auth_token" = MTQ1MTU2NzE3NLGdumeBi7ah;
avatar = "http://7u2nh5.com2.z0.glb.qiniucdn.com/2015-12-03/565fad78bcbcd.jpg";
birthday = "2015-11-30";
email = "";
endtime = 1451567174;
"img_url" = "http://7u2nh5.com2.z0.glb.qiniucdn.com/";
mobile = "189****7621";
"msglog_url" = "http://7xjxp7.com2.z0.glb.qiniucdn.com/";
nickname = "\U8bb0\U5f97\U8bb0\U5f97\U8bb0\U5f97\U8bb0\U5f97\U8bb0\U5f97\U8bb0\U5f97\U5c31\U5206\U5f00\U7684\U8bb0\U5f97\U8bb0\U5f97";
"refresh_token" = MTQ1MzU1NDM3NLGdumeBi7ah;
school = 1020894;
"school_str" = "\U5929\U7a7a\U4e4b\U57ce";
sex = 2;
signature = "\U6536\U62fe\U6536\U62fef\U8fc7\U5206\U53cd\U53cd\U590d\U590d\U53cd\U53cd\U590d\U590d\U521a\U521a\U560e\U560e\U560e\U560evvggggg\U70e6\U70e6";
type = 1;
"uc_id" = 823088;
uid = 66954;
"upload_msgtoken" = "LOXIuwwTU5v3B1BKqLgH-ju77Q2ht7GfBzNfRj8M:jmymSyuEeutrkICJkKbqDnoW68o=:eyJzY29wZSI6InBlaXlpbmxvZyIsImRlYWRsaW5lIjoxNDY2NTE0Mzc0fQ==";
"upload_token" = "LOXIuwwTU5v3B1BKqLgH-ju77Q2ht7GfBzNfRj8M:mP_eTwLHVgP857D2HYSAA9Bnxr0=:eyJzY29wZSI6InBlaXlpbiIsImRlYWRsaW5lIjoxNDY2NTE0Mzc0fQ==";
};
msg = "";
status = 1;
}
*/
class UserInfo: NSObject {
    var auth_token : String?
    var avatar : String?
    var nickname : String?
    var uc_id : Int64 = 0
    var uid : Int64 = 0
    var sex : Int = 1

}

extension UserInfo : JsonToObject{
     class func toObject(json: JSON?) -> UserInfo? {
        let info = UserInfo()
        info.auth_token = json?.getString("auth_token")
        info.avatar = json?.getString("avatar")
        info.nickname = json?.getString("nickname")
        info.sex = (json?.getInt("sex"))!
        return info
    }

}

extension JSON{
    func getString(key:String)->String?{
       return dictionaryValue["\(key)"]?.string
    }
}
extension JSON{
    func getInt(key:String)->Int?{
        return dictionaryValue["\(key)"]?.int
    }
}