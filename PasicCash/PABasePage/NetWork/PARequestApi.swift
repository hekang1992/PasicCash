//
//  PARequestApi.swift
//  PasicCash
//
//  Created by apple on 2024/7/3.
//

import UIKit
import Foundation
import BRPickerView

let SCHEME_URL = "happy://are.you"

let BASE_URL = "http://8.220.130.37:9023"

let GIT_URL = "https://raw.githubusercontent.com/dtsdark/sicass/main/wokrje"

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
