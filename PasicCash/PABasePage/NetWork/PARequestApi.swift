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

let BASE_URL = "https://pasigborongan.com/"

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
    class func getNavigationController(from viewController: PABaseViewController) -> PANavigationViewController? {
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
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return nil
        }
        var rootViewController = window.rootViewController
        while let presentedViewController = rootViewController?.presentedViewController {
            rootViewController = presentedViewController
        }
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController as? PANavigationViewController
        } else if let navigationController = rootViewController?.navigationController {
            return navigationController as? PANavigationViewController
        }
        return nil
    }
}

class CountdownManager {
    private static var countdownTimer: Timer?
    private static var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    class func startCountdown(startDate: Date, duration: TimeInterval, updateHandler: @escaping (Int, Int, Int) -> Void) {
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

class sanjiModel {
    static func getsanjiArr(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var tempArr1 = [BRProvinceModel]()
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? plantsModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.code = proviceDic.formy
            proviceModel.name = proviceDic.hoses
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            let cityList = proviceDic.plants ?? proviceDic.plants ?? []
            var tempArr2 = [BRCityModel]()
            for cityDic in cityList {
                let cityModel = BRCityModel()
                cityModel.code = cityDic.formy
                cityModel.name = cityDic.hoses
                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
                let areaList = cityDic.plants ?? cityDic.plants ?? []
                var tempArr3 = [BRAreaModel]()
                for areaDic in areaList {
                    let areaModel = BRAreaModel()
                    areaModel.code = areaDic.formy
                    areaModel.name = areaDic.hoses
                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
                    tempArr3.append(areaModel)
                }
                cityModel.arealist = tempArr3
                tempArr2.append(cityModel)
            }
            proviceModel.citylist = tempArr2
            tempArr1.append(proviceModel)
        }
        return tempArr1
    }
}

class erjiModel {
    static func geterjiArr(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var tempArr1 = [BRProvinceModel]()
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? birdsModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.code = proviceDic.goneup
            proviceModel.name = proviceDic.hoses
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            let cityList = proviceDic.birds ?? proviceDic.birds ?? []
            var tempArr2 = [BRCityModel]()
            for cityDic in cityList {
                let cityModel = BRCityModel()
                cityModel.code = cityDic.goneup
                cityModel.name = cityDic.hoses
                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
                let areaList = cityDic.birds ?? cityDic.birds ?? []
                var tempArr3 = [BRAreaModel]()
                for areaDic in areaList {
                    let areaModel = BRAreaModel()
                    areaModel.code = areaDic.goneup
                    areaModel.name = areaDic.hoses
                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
                    tempArr3.append(areaModel)
                }
                cityModel.arealist = tempArr3
                tempArr2.append(cityModel)
            }
            proviceModel.citylist = tempArr2
            tempArr1.append(proviceModel)
        }
        return tempArr1
    }
}

class yijiModel {
    static func getyijiArr(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var result = [BRProvinceModel]()
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? birdsModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.code = proviceDic.goneup
            proviceModel.name = proviceDic.hoses
            let sreally = proviceDic.sreally ?? ""
            if !sreally.isEmpty {
                proviceModel.picUrl = proviceDic.sreally
            }
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            result.append(proviceModel)
        }
        return result
    }
}
