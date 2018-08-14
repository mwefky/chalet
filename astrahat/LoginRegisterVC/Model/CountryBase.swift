//
//  CountryBase.swift
//  astrahat
//
//  Created by on on 8/10/18.
//  Copyright © 2018 on. All rights reserved.
//

import Foundation
import ObjectMapper


class CountryBase : NSObject, NSCoding, Mappable{
    
    var code : Int?
    var data : [countryData]?
    var message : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return CountryBase()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        code <- map["code"]
        data <- map["data"]
        message <- map["message"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        code = aDecoder.decodeObject(forKey: "code") as? Int
        data = aDecoder.decodeObject(forKey: "data") as? [countryData]
        message = aDecoder.decodeObject(forKey: "message") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        
    }
    
}
