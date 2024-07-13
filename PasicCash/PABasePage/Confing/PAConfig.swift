//
//  PAConfig.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit
import Foundation

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let LilitaOneFont = "LilitaOne"

let IS_SHOWLAND = "IS_SHOWLAND"

let PA_LOGIN = "PA_LOGIN"

let PA_SESSIONID = "PA_SESSIONID"

let ROOT_VC = "ROOT_VC"

var IS_LOGIN: Bool {
    if let sessionID = UserDefaults.standard.object(forKey: PA_SESSIONID) as? String {
        return !sessionID.isEmpty
    } else {
        return false
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            self.init(white: 0.0, alpha: 0.0)
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UILabel {
    static func buildLabel(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.font = font
        return label
    }
}

extension Double {
    func ppaix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension CGFloat {
    func ppaix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension Int {
    func ppaix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension Data {
    static func yasuoQuality(image: UIImage, maxLength: Int) -> Data? {
        var compression: CGFloat = 0.8
        var minCompression: CGFloat = 0.0
        var maxCompression: CGFloat = 1.0
        var data = image.jpegData(compressionQuality: compression)
        if let imageData = data, imageData.count <= maxLength {
            return imageData
        }
        repeat {
            compression = (maxCompression + minCompression) / 2.0
            data = image.jpegData(compressionQuality: compression)
            guard let imageData = data else { break }
            if imageData.count <= maxLength {
                minCompression = compression
            } else {
                maxCompression = compression
            }
        } while abs(maxCompression - minCompression) > 0.01
        return data
    }
}
