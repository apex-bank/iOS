//
//  Reachability.swift
//  Apex
//
//  Created by Brett Hales on 4/11/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//


import SystemConfiguration

open class Reachability
{
    class func isConnectedToNetwork() -> Bool
    {
        var address = sockaddr_in()
        address.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        address.sin_family = sa_family_t(AF_INET)
        
        guard let reachability = withUnsafePointer(to: &address,
                                                   { pointer in
                                                    return pointer.withMemoryRebound(to: sockaddr.self, capacity: MemoryLayout<sockaddr>.size)
                                                    {
                                                        return SCNetworkReachabilityCreateWithAddress(nil, $0)
                                                    }
        })
            else
        {
            return false;
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(reachability, &flags)
        {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
