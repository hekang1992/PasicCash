//
//  PATotalModel.swift
//  PasicCash
//
//  Created by apple on 2024/7/3.
//

import Foundation
import HandyJSON

class LocationModel: NSObject {
    var asnowman : String = ""//省
    var shaped : String = ""//cn
    var twinkling : String = ""//china
    var glanced : String = ""//街道
    var molded : String = ""//市
    var swaistline: Double = 0.0//维度
    var stomach: Double = 0.0//经度
}

class BaseModel: HandyJSON {
    required init() {}
    var handsto: Int?
    var jiffy: String?
    var shepointed: [String: Any]?
}

class ShepointedModel: HandyJSON {
    required init() {}
}
