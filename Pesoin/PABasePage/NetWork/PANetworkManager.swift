//
//  PANetworkManager.swift
//  Pesoin
//
//  Created by apple on 2024/7/3.
//

import Alamofire
import Reachability

class PANetworkManager {
    
    enum NetworkStatus {
        case wifi
        case cellular
        case none
    }

    var typeSty: String = "NONE"
    
    static let shared = PANetworkManager()
    
    private let reachability = try!Reachability()
    
    typealias NetworkStatusHandler = (NetworkStatus) -> Void
    
    private var networkStatusHandler: NetworkStatusHandler?
    
    private init() {
        setupReachability()
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
}


extension PANetworkManager {
    
    private func setupReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("无法开始网络状态监测")
        }
    }
    
    @objc func networkStatusChanged() {
        if reachability.connection != .unavailable {
            if reachability.connection == .wifi {
                typeSty = "WIFI"
                notifyNetworkStatus(.wifi)
            } else {
                typeSty = "4G/5G"
                notifyNetworkStatus(.cellular)
            }
        } else {
            typeSty = "NONE"
            notifyNetworkStatus(.none)
        }
    }
    
    func observeNetworkStatus(_ handler: @escaping NetworkStatusHandler) {
        networkStatusHandler = handler
    }
    
    private func notifyNetworkStatus(_ status: NetworkStatus) {
        if status == .none {
            networkStatusHandler?(status)
        }else {
            reachability.stopNotifier()
            NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
            networkStatusHandler?(status)
        }
    }
    
}
