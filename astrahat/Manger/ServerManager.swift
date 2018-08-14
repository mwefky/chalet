//
//  ServerManager.swift
//  astrahat
//
//  Created by on on 8/9/18.
//  Copyright © 2018 on. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


let hostName = "http://ist.wisyst.info/"


enum ServiceName: String {
    case login = "oauth/token"
    case countries = "api/countries"
    case district = "api/cities"
    case register = "api/register"
}


class ServerManager {
    
    func perform(methodType: HTTPMethod = .post,needToken: Bool = false, serviceName: ServiceName, parameters: [String: AnyObject]? = nil, completionHandler: @escaping (Any?, String?) -> Void)-> Void {
        
        
        let urlString = "\(hostName)\(serviceName.rawValue)"
        
        
        print("ServiceName:\(serviceName)  parameters: \(String(describing: parameters))")
        
        var headers: HTTPHeaders = ["Content-Type": "application/json", "Accept" : "application/json"]
//                                    "locale": L102Language.currentAppleLanguage()]
        
        if needToken {
//            headers["Authorization"] = "Bearer \(User.shared.jwtToken())"
//            print("Jwt Token : Bearer \(User.shared.jwtToken())")
        }
        
        
        Alamofire.request(urlString, method: methodType, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            
            debugPrint(response)
            let statusCode = response.response?.statusCode
            
            if response.result.isSuccess {
                let dict = response.result.value!
                
                if serviceName == .login && statusCode == 406 {
                    completionHandler(nil, "406")
                    return
                }
                
                if (statusCode! >= 200) && (statusCode! < 300){
                    completionHandler(dict, nil)
                }else{
                    let responseDict = dict as! [String: Any]
                    
                    guard let errorArr = responseDict["message"] as? [String] else {
                        let errorStr = responseDict["message"] as! String
                        completionHandler(nil, errorStr)
                        return
                    }
                    
                    completionHandler(nil, errorArr[0])
                    
                }
                
            }
            else { //FAILURE
                print("error \(String(describing: response.result.error)) in serviceName: \(serviceName)")
                completionHandler(nil, response.result.error?.localizedDescription)
            }
        }
    }
    
    
    func performGet(methodType: HTTPMethod = .get, needToken: Bool = false, serviceName: ServiceName, url: String, parameters: [String: String]? = nil, completionHandler: @escaping (Any?, String?) -> Void)-> Void {
        
        print("ServiceName:\(serviceName)  parameters: \(String(describing: parameters))")
        
        var headers: HTTPHeaders = ["Content-Type": "application/json", "Accept" : "application/json"]
//                                    "locale": L102Language.currentAppleLanguage()]
        
        if needToken {
//            headers["Authorization"] = "Bearer \(User.shared.jwtToken())"
        }
        
        
        Alamofire.request(url, method: methodType, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            
            debugPrint(response)
            let statusCode = response.response?.statusCode
            
            if response.result.isSuccess {
                let dict = response.result.value!
                
                
                if (statusCode! >= 200) && (statusCode! < 300){
                    completionHandler(dict, nil)
                }else{
                    let responseDict = dict as! [String: Any]
                    
                    guard let errorArr = responseDict["errors"] as? [String] else {
                        let errorStr = responseDict["error"] as! [String]
                        completionHandler(nil, errorStr[0])
                        return
                    }
                    
                    completionHandler(nil, errorArr[0])
                }
                
            }
            else { //FAILURE
                print("error \(String(describing: response.result.error)) in serviceName: \(serviceName)")
                completionHandler(nil, response.result.error?.localizedDescription)
            }
        }
    }
    
}
