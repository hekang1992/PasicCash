//
//  PATotalModel.swift
//  Pesoin
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

class shepointedModel: HandyJSON {
    required init() {}
    var likethat: LikethatModel?
    var saidjem: saidjemModel?
    var andcrept: andcreptModel?
    var credential: credentialModel?
    var overcoat: overcoatModel?
    var req: reqModel?
    var reqImg: reqModel?
    var cashClas: [cashClasModel]?
    var frames: framesModel?
    var myshoulders: myshouldersModel?
    var sounds: [soundsModel]?
    var twitch: [[twitchModel]]?
    var undress: [undressModel]?
    var perfect: [perfectModel]?
    var plants: [plantsModel]?
    var predictions: predictionsModel?
    var nightwas: String?
    var lively: String?
    var hoses: String?
    var mattress: String?
    var shouts: String?
    var tthey: String?
    var truck: String?
    var acrowd: String?
    var flowFind: String?
    var earTree: String?
    var usingWare: String?
}

class predictionsModel: HandyJSON {
    required init() {}
    var plants: [plantsModel]?
}


class perfectModel: HandyJSON {
    required init() {}
    var forcovering: String?
    var riverbank: String?
    var cocoa: String?
}

class undressModel: HandyJSON {
    required init() {}
    var goneup: String?
    var lively: String?
}

class twitchModel: HandyJSON {
    required init() {}
    var forcovering: String?
    var pester: String?
    var goneup: String?
    var birds: [birdsModel]?
}

class soundsModel: HandyJSON {
    required init() {}
    var cordial: String?
    var andmen: String?
    var taffeta: String?
    var pester: String?
    var goneup: String?
    var rains: String?
    var handsto: String?
    var sounds: [soundsModel]?
    var birds: [birdsModel]?
}

class birdsModel: HandyJSON {
    required init() {}
    var goneup: String?
    var hoses: String?
    var sreally: String?
    var birds: [birdsModel]?
}

class myshouldersModel: HandyJSON {
    required init() {}
    var nightshirts: String?
}

class framesModel: HandyJSON {
    required init() {}
    var smoke: String?
}

class LoginModel: HandyJSON {
    required init() {}
    var crisscrossed: String?
    var ruined: String?//phone
    var baffled: String?//sessionID
}

class BearuftModel: HandyJSON {
    required init() {}
    var bearuft: String?
}

class reqModel: HandyJSON {
    required init() {}
    var danger: [dangerModel]?
}

class saidjemModel: HandyJSON {
    required init() {}
    var goneup: String?
    var danger: dangerModel?
}

class LikethatModel: HandyJSON {
    required init() {}
    var goneup: String?
    var danger: [dangerModel]?
}

class credentialModel: HandyJSON {
    required init() {}
    var goneup: String?
    var danger: [dangerModel]?
}

class andcreptModel: HandyJSON {
    required init() {}
    var cordial: String?
    var thathe: Int?
    var betterkeep: Int?
    var plants: [plantsModel]?
}

class plantsModel: HandyJSON {
    required init() {}
    var forcovering: String?
    var lively: String?
    var smoke: String?
    var eaten: String?
    var cordial: String?
    var someday: String?
    var hoses: String?
    var formy: String?
    var heavyoak: String?
    var erected: String?
    var direst: String?
    var bringing: String?
    var surprised: String?
    var lovely: String?
    var dandy: String?
    var creation: String?
    var charred: String?
    var saving: String?
    var shyly: String?
    var phrase: [birdsModel]?
    var plants: [plantsModel]?
}

class dangerModel: HandyJSON {
    required init() {}
    var nightwas: String?//url
    var perplexity: String?
    var affairs: String?
    var cordial: String?
    var lively: String?//picurl
    var ashambles: String?
    var formy: String?
    var bringing: String?
    var settin: String?
    var gazingat: String?
    var freshadventure: String?
    var amber: String?
    var theblanket: String?
    var contests: String?
    var feedback: String?
    var scoreImg: String?
    var experienced: String?
    var cocoa: String?
}

class overcoatModel: HandyJSON {
    required init() {}
    var chuckling: String?
    var bearuft: String?
    var clank: String?
    var shutUp: String?
    var shutDown: String?
    var blueFine: String?
    var redFine: String?
    var idecided: String?
    var forthe: String?
    var chainanyway: String?
}

class cashClasModel: HandyJSON {
    required init() {}
    var couldYouHa: String?
    var geminiFlas: String?
    var turbo: String?
    var flowFind: String?
    var riverbank: String?
}
