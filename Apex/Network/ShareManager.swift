//
//  ShareManager.swift
//  Apex
//
//  Created by Brett Hales on 4/11/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import Foundation

class ShareManager {
    
    static let sharedInstance = ShareManager()
    
    var accessToken: String = ""
    var deviceToken: String = ""
    var currentUser: User? = nil
    var APIUrl: String = ""
    
    public static var DOTNET_UTC_TIME_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    public static var DOTNET_UTC_TIME_FORMAT2 = "yyyy-MM-dd'T'HH:mm:ssZ";
    
}
