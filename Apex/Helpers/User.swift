//
//  User.swift
//  Apex
//
//  Created by Brett Hales on 4/11/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import Foundation

struct User: Codable {
    var uid: Int
    var firstName: String?
    var lastName: String?
    var pincode: String?
    var phoneNumber: String?
    var email: String?
    var authenticationToken: String?
    var dob: Int?
    var created_at: Date?
    var updated_at: Date?
    var gender: String?
    var address: String?
    var employments: String?
    var nationality: String?
}
