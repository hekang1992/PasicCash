//
//  PADeviceInfo.swift
//  PasicCash
//
//  Created by apple on 2024/7/3.
//

import UIKit
import AdSupport
import AppTrackingTransparency
import SAMKeychain
import SystemConfiguration

class PADeviceInfo {
    
    static func requestIDFA(completion: @escaping (String?) -> Void) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    let idfa = ASIdentifierManager.shared().advertisingIdentifier
                    completion(idfa.uuidString)
                case .denied, .restricted, .notDetermined:
                    completion(nil)
                @unknown default:
                    completion(nil)
                }
            }
        } else {
            let idfa = ASIdentifierManager.shared().advertisingIdentifier
            completion(idfa.uuidString)
        }
    }
    
   static func getIDFV() -> String? {
        if let uuid = SAMKeychain.password(forService: "Key_Service", account: "Key_Account"), !uuid.isEmpty {
            return uuid
        } else {
            if let deviceIDFV = UIDevice.current.identifierForVendor?.uuidString {
                let success = SAMKeychain.setPassword(deviceIDFV, forService: "Key_Service", account: "Key_Account")
                if success {
                    print("UUID>>>>>>>>\(deviceIDFV)")
                    return deviceIDFV
                } else {
                    return ""
                }
            } else {
                return ""
            }
        }
    }
    
    static func usingProxy() -> String {
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any],
           let proxies = CFNetworkCopyProxiesForURL(URL(string: "https://www.google.com")! as CFURL, proxySettings as CFDictionary).takeRetainedValue() as? [Any],
           let settings = proxies.first as? [AnyHashable: Any],
           let proxyType = settings[kCFProxyTypeKey] as? String {
            if proxyType == kCFProxyTypeNone as String {
                return "0"
            } else {
                return "1"
            }
        }
        return "0"
    }
    
    static func vpnConnected() -> String {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sa_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return "0"
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return "0"
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection ? "1" : "0"
    }
    
    static func getCurrentTime() -> String {
        let currentTime = Date().timeIntervalSince1970
        let currentTimeMillis = String(Int64(currentTime * 1000))
        return currentTimeMillis
    }
    
}
