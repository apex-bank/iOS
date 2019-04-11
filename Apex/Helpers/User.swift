//
//  User.swift
//  Apex
//
//  Created by Brett Hales on 4/11/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import Foundation

struct User: Codable {
    var userID: Int
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var email: String?
}
