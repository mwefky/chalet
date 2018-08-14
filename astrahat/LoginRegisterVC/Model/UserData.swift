//
//  UserData.swift
//  astrahat
//
//  Created by on on 8/14/18.
//  Copyright © 2018 on. All rights reserved.
//

import Foundation
import ObjectMapper


class UserData : NSObject, NSCoding, Mappable{
    static let shared = UserData()
    
    var cityId : String?
    var cityInfo : CityInfo?
    var countryId : String?
    var countryInfo : CountryInfo?
    var createdAt : String?
    var email : AnyObject?
    var expiresIn : Int?
    var firebase : String?
    var id : Int?
    var image : String?
    var name : String?
    var phone : String?
    var refreshToken : String?
    var roleId : String?
    var status : String?
    var tokenType : String?
    var updatedAt : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return UserData()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        cityId <- map["city_id"]
        cityInfo <- map["city_info"]
        countryId <- map["country_id"]
        countryInfo <- map["country_info"]
        createdAt <- map["created_at"]
        email <- map["email"]
        expiresIn <- map["expires_in"]
        firebase <- map["firebase"]
        id <- map["id"]
        image <- map["image"]
        name <- map["name"]
        phone <- map["phone"]
        refreshToken <- map["refresh_token"]
        roleId <- map["role_id"]
        status <- map["status"]
        tokenType <- map["token_type"]
        updatedAt <- map["updated_at"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        cityId = aDecoder.decodeObject(forKey: "city_id") as? String
        cityInfo = aDecoder.decodeObject(forKey: "city_info") as? CityInfo
        countryId = aDecoder.decodeObject(forKey: "country_id") as? String
        countryInfo = aDecoder.decodeObject(forKey: "country_info") as? CountryInfo
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        email = aDecoder.decodeObject(forKey: "email") as? AnyObject
        expiresIn = aDecoder.decodeObject(forKey: "expires_in") as? Int
        firebase = aDecoder.decodeObject(forKey: "firebase") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        image = aDecoder.decodeObject(forKey: "image") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        refreshToken = aDecoder.decodeObject(forKey: "refresh_token") as? String
        roleId = aDecoder.decodeObject(forKey: "role_id") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        tokenType = aDecoder.decodeObject(forKey: "token_type") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if cityId != nil{
            aCoder.encode(cityId, forKey: "city_id")
        }
        if cityInfo != nil{
            aCoder.encode(cityInfo, forKey: "city_info")
        }
        if countryId != nil{
            aCoder.encode(countryId, forKey: "country_id")
        }
        if countryInfo != nil{
            aCoder.encode(countryInfo, forKey: "country_info")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if expiresIn != nil{
            aCoder.encode(expiresIn, forKey: "expires_in")
        }
        if firebase != nil{
            aCoder.encode(firebase, forKey: "firebase")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if refreshToken != nil{
            aCoder.encode(refreshToken, forKey: "refresh_token")
        }
        if roleId != nil{
            aCoder.encode(roleId, forKey: "role_id")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if tokenType != nil{
            aCoder.encode(tokenType, forKey: "token_type")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        
    }
    
}
