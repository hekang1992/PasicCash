//
//  PAConfig.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit
import Foundation
import BRPickerView

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let LilitaOneFont = "LilitaOne"

let IS_SHOWLAND = "IS_SHOWLAND"

let PHONE_LOGIN = "PHONE_LOGIN"

let PHONE_SESSIONID = "PHONE_SESSIONID"

let ROOT_VC = "ROOT_VC"

var IS_LOGIN: Bool {
    if let sessionID = UserDefaults.standard.object(forKey: PHONE_SESSIONID) as? String {
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
    static func createLabel(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.backgroundColor = UIColor.clear
        return label
    }
}

extension Double {
    func pix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension CGFloat {
    func pix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension Int {
    func pix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension CGFloat {
    func minus() -> CGFloat{
        return 0 - self
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


class NoCopyPasteTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) ||
            action == #selector(paste(_:)) ||
            action == #selector(cut(_:)) ||
            action == #selector(select(_:)) ||
            action == #selector(selectAll(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

class DelayUtils {
    static func delay(_ delay: TimeInterval, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
    }
}

class PATabBarManager {
    static func showTabBar() {
        if let navigationController = UIApplication.shared.delegate?.window??.rootViewController as? PANavigationViewController {
            if let tabBarController = navigationController.viewControllers.first as? PATabBarViewController {
                tabBarController.showTabBar()
            }
        }
    }
    static func hideTabBar() {
        if let navigationController = UIApplication.shared.delegate?.window??.rootViewController as? PANavigationViewController {
            if let tabBarController = navigationController.viewControllers.first as? PATabBarViewController {
                tabBarController.hideTabBar()
            }
        }
    }
}

class NavigationControllerHelper {
    class func getNavigationController(from viewController: UIViewController) -> PANavigationViewController? {
        if let navigationController = viewController.navigationController {
            return navigationController as? PANavigationViewController
        } else if let tabBarController = viewController.tabBarController {
            if let selectedController = tabBarController.selectedViewController as? UINavigationController {
                return selectedController as? PANavigationViewController
            }
        }
        return nil
    }
    
    class func getRootNavigationController() -> PANavigationViewController? {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            if let navigationController = rootViewController as? UINavigationController {
                return navigationController as? PANavigationViewController
            } else if let tabBarController = rootViewController as? UITabBarController {
                if let selectedController = tabBarController.selectedViewController as? UINavigationController {
                    return selectedController as? PANavigationViewController
                }
            }
        }
        return nil
    }
}

class CountdownManager {
    private static var countdownTimer: Timer?
    private static var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    private static let duration: TimeInterval = 48 * 60 * 60
    
    class func startCountdown(startDate: Date, updateHandler: @escaping (Int, Int, Int) -> Void) {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let timeRemaining = timeRemaining(from: startDate, duration: duration)
            updateHandler(timeRemaining.hours, timeRemaining.minutes, timeRemaining.seconds)
        }
        let timeRemainin = timeRemaining(from: startDate, duration: duration)
        updateHandler(timeRemainin.hours, timeRemainin.minutes, timeRemainin.seconds)
    }
    
    class func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    private class func timeRemaining(from startDate: Date, duration: TimeInterval) -> (hours: Int, minutes: Int, seconds: Int) {
        let endDate = startDate.addingTimeInterval(duration)
        let now = Date()
        let remainingTime = endDate.timeIntervalSince(now)
        if remainingTime < 0 {
            return (0, 0, 0)
        }
        let hours = Int(remainingTime) / 3600
        let minutes = (Int(remainingTime) % 3600) / 60
        let seconds = Int(remainingTime) % 60
        
        return (hours, minutes, seconds)
    }
}

class DateConverter {
    static func date(from timestampString: String, inMilliseconds: Bool = false) -> Date? {
        guard let timestamp = Double(timestampString) else {
            return nil
        }
        let timestampInSeconds = inMilliseconds ? timestamp / 1000.0 : timestamp
        return Date(timeIntervalSince1970: timestampInSeconds)
    }
    static func formattedDateString(from date: Date, dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium, locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        dateFormatter.locale = locale
        return dateFormatter.string(from: date)
    }
}

//class ProvinceModelConverter {
//    static func getProvinceModelArr(dataSourceArr: [Any]) -> [BRProvinceModel] {
//        var tempArr1 = [BRProvinceModel]()
//        for proviceDic in dataSourceArr {
//            guard let proviceDic = proviceDic as? PlaceModel else {
//                continue
//            }
//            let proviceModel = BRProvinceModel()
//            proviceModel.code = proviceDic.particularly
//            proviceModel.name = proviceDic.employment
//            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
//            let cityList = proviceDic.palace ?? proviceDic.palace ?? []
//            var tempArr2 = [BRCityModel]()
//            for cityDic in cityList {
//                let cityModel = BRCityModel()
//                cityModel.code = cityDic.particularly
//                cityModel.name = cityDic.employment
//                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
//                let areaList = cityDic.palace ?? cityDic.palace ?? []
//                var tempArr3 = [BRAreaModel]()
//                for areaDic in areaList {
//                    let areaModel = BRAreaModel()
//                    areaModel.code = areaDic.particularly
//                    areaModel.name = areaDic.employment
//                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
//                    tempArr3.append(areaModel)
//                }
//                cityModel.arealist = tempArr3
//                tempArr2.append(cityModel)
//            }
//            proviceModel.citylist = tempArr2
//            tempArr1.append(proviceModel)
//        }
//        return tempArr1
//    }
//}

//class GetPayday {
//    static func getPaydayModelArr(dataSourceArr: [Any]) -> [BRProvinceModel] {
//        var tempArr1 = [BRProvinceModel]()
//        for proviceDic in dataSourceArr {
//            guard let proviceDic = proviceDic as? ChildrenModel else {
//                continue
//            }
//            let proviceModel = BRProvinceModel()
//            proviceModel.code = proviceDic.excuse
//            proviceModel.name = proviceDic.employment
//            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
//            let cityList = proviceDic.children ?? proviceDic.children ?? []
//            var tempArr2 = [BRCityModel]()
//            for cityDic in cityList {
//                let cityModel = BRCityModel()
//                cityModel.code = cityDic.excuse
//                cityModel.name = cityDic.employment
//                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
//                let areaList = cityDic.children ?? cityDic.children ?? []
//                var tempArr3 = [BRAreaModel]()
//                for areaDic in areaList {
//                    let areaModel = BRAreaModel()
//                    areaModel.code = areaDic.excuse
//                    areaModel.name = areaDic.employment
//                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
//                    tempArr3.append(areaModel)
//                }
//                cityModel.arealist = tempArr3
//                tempArr2.append(cityModel)
//            }
//            proviceModel.citylist = tempArr2
//            tempArr1.append(proviceModel)
//        }
//        return tempArr1
//    }
//}

class yijiModel {
    static func getSimpleModelArr(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var result = [BRProvinceModel]()
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? birdsModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.code = proviceDic.goneup
            proviceModel.name = proviceDic.hoses
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            result.append(proviceModel)
        }
        return result
    }
}
