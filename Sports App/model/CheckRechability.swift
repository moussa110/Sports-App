//
//  CheckRechability.swift
//  Sports App
//
//  Created by MacOSSierra on 3/4/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import Foundation
import Reachability

protocol CheckIsOnlineDelegete {
    func checkIsOnline(isOnline:Bool);
}

struct CheckRechability{
    
    var delegete:CheckIsOnlineDelegete?;

    
    func checkNetworkConnection() {
       
        let reachability = try! Reachability()
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
           
        }
        reachability.whenUnreachable = { _ in
           print("Reachable ssssss")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
}
