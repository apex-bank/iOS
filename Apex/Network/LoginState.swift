//
//  LoginState.swift
//  Apex
//
//  Created by Brett Hales on 4/11/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import Foundation
import SwiftyJSON

public class LoginState {
    public var mobile: String = ""
    public var loginState: Bool = false
    
    public init(json: JSON)
    {
        mobile = json["mobile"].stringValue
        loginState = json["loginState"].boolValue
    }
}

public class SignUpResponse: Codable {
    
    public var status: Bool
    public var data: JSON
    public var msg: String
    
    public enum CodingKeys: String, CodingKey {
        case status
        case data
        case msg
    }
}

public class LoginResponse: Codable {
    
    public var status: Bool
    public var msg: String
    
    public enum CodingKeys: String, CodingKey {
        case status
        case msg
    }
}

public class MagicLinkResponse: Codable {
    public var status: Bool
    public var data: JSON
    
    public enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}

