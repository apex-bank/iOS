//
//  NetworkConnection.swift
//  Apex
//
//  Created by Brett Hales on 4/11/19.
//  Copyright © 2019 Brett Hales. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

open class Network {
    
    public static let Connection = Network()
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(identifier: "UTC")
            formatter.dateFormat = ShareManager.DOTNET_UTC_TIME_FORMAT
            if let date = formatter.date(from: dateString) {
                return date
            }
            formatter.dateFormat = ShareManager.DOTNET_UTC_TIME_FORMAT2
            if let date = formatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Cannot decode date string \(dateString)")
        }
        return decoder
    }()
    
    fileprivate init()
    {
        SetAuthCookie();
    }
    
    open func loginWithEmail(requestData: JSON, completion: @escaping (_ result: LoginResponse?) -> Void) -> Void
    {
        if (!Reachability.isConnectedToNetwork())
        {
            completion(nil)
        }
        else
        {
            let parameters = requestData.dictionaryObject
            let url = String(format: "%@/users/login", ShareManager.sharedInstance.APIUrl)
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString
                { response in
                    
                    switch response.result
                    {
                    case .success:
                        do {
                            let result = try self.decoder.decode(LoginResponse.self, from: response.data!)
                            completion(result)
                        } catch let parsingError {
                            print("Error", parsingError)
                            completion(nil)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
            }
        }
    }
    
    open func verifywithMagicLink(requestData: JSON, queue: DispatchQueue?, completion: @escaping (_ result: MagicLinkResponse?) -> Void) -> Void
    {
        if (!Reachability.isConnectedToNetwork())
        {
            completion(nil)
        }
        else
        {
            let parameters = requestData.dictionaryObject
            let url = String(format: "%@/auth/sign_in", ShareManager.sharedInstance.APIUrl)
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString
                { response in
                    if let headers = response.response?.allHeaderFields as? [String: String] {
                        print("Verify magic link header data: \(headers)")
                        if let accessToken = headers["Access-Token"] {
                            ShareManager.sharedInstance.accessToken = accessToken
                            let defaults = UserDefaults.standard
                            defaults.set(accessToken, forKey: "accessToken")
                            self.SetAuthCookie()
                        }
                    }
                    switch response.result
                    {
                    case .success:
                        do {
                            let result = try self.decoder.decode(MagicLinkResponse.self, from: response.data!)
                            completion(result)
                        } catch let parsingError {
                            print("Error", parsingError)
                            completion(nil)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
            }
        }
    }
    
    open func getMagicLink(requestEmail: String, queue: DispatchQueue?, completion: @escaping (_ result: MagicLinkResponse?) -> Void) -> Void
    {
        if (!Reachability.isConnectedToNetwork())
        {
            completion(nil)
        }
        else
        {
            let url = String(format: "%@/users/get_magic_link?email=%@", ShareManager.sharedInstance.APIUrl, requestEmail)
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseString
                { response in
                    
                    switch response.result
                    {
                    case .success:
                        do {
                            let result = try self.decoder.decode(MagicLinkResponse.self, from: response.data!)
                            completion(result)
                        } catch let parsingError {
                            print("Error", parsingError)
                            completion(nil)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
            }
        }
    }
    
    open func uploadSignUpInfo(requestData: JSON, completion: @escaping (_ result: SignUpResponse?) -> Void) -> Void
    {
        if (!Reachability.isConnectedToNetwork())
        {
            completion(nil)
        }
        else
        {
            let parameters = requestData.dictionaryObject
            
            let url = String(format: "%@/auth", ShareManager.sharedInstance.APIUrl)
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString
                { response in
                    
                    switch response.result
                    {
                    case .success:
                        do {
                            let result = try self.decoder.decode(SignUpResponse.self, from: response.data!)
                            completion(result)
                        } catch let parsingError {
                            print("Error", parsingError)
                            completion(nil)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
            }
        }
    }
    
    open func uploadFacebookAuth(requestData: JSON, completion: @escaping (_ result: SignUpResponse?) -> Void) -> Void
    {
        if (!Reachability.isConnectedToNetwork())
        {
            completion(nil)
        }
        else
        {
            let parameters = requestData.dictionaryObject
            
            let url = String(format: "%@/omniauths/facebook_login", ShareManager.sharedInstance.APIUrl)
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString
                { response in
                    
                    switch response.result
                    {
                    case .success:
                        do {
                            let result = try self.decoder.decode(SignUpResponse.self, from: response.data!)
                            completion(result)
                        } catch let parsingError {
                            print("Error", parsingError)
                            completion(nil)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
            }
        }
    }
    
    open func checkLoginState(requestData: JSON, completion: @escaping (_ result: LoginState?) -> Void) -> Void
    {
        if (!Reachability.isConnectedToNetwork())
        {
            completion(nil)
        }
        else
        {
            let parameters = requestData.dictionaryObject
            
            let url = String(format: "%@/checkLoginState", ShareManager.sharedInstance.APIUrl)
            Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseString
                { response in
                    
                    switch response.result
                    {
                    case .success(let data):
                        let json = JSON(data)
                        let result = LoginState(json: json)
                        completion(result)
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
            }
        }
    }
    
    
    
    public func SetAuthCookie()
    {
        if (ShareManager.sharedInstance.accessToken != "")
        {
            let properties = [
                HTTPCookiePropertyKey.originURL: ShareManager.sharedInstance.APIUrl,
                HTTPCookiePropertyKey.path: "/",
                HTTPCookiePropertyKey.name: ".cowboy",
                HTTPCookiePropertyKey.value: ShareManager.sharedInstance.accessToken,
                ]
            
            let cookie = HTTPCookie(properties: properties)!
            
            Alamofire.SessionManager.default.session.configuration.httpShouldSetCookies = true;
            Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookie(cookie)
            
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 60;
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource = 60;
        }
    }
}
