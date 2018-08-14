//
//  DistrictData.swift
//  astrahat
//
//  Created by on on 8/11/18.
//  Copyright © 2018 on. All rights reserved.
//

import Foundation
import ObjectMapper


class DistrictData : NSObject, NSCoding, Mappable{
    
    var countryId : String?
    var createdAt : String?
    var id : Int?
    var nameAr : String?
    var nameEn : String?
    var updatedAt : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return DistrictData()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        countryId <- map["country_id"]
        createdAt <- map["created_at"]
        id <- map["id"]
        nameAr <- map["name_ar"]
        nameEn <- map["name_en"]
        updatedAt <- map["updated_at"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        countryId = aDecoder.decodeObject(forKey: "country_id") as? String
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        nameAr = aDecoder.decodeObject(forKey: "name_ar") as? String
        nameEn = aDecoder.decodeObject(forKey: "name_en") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if countryId != nil{
            aCoder.encode(countryId, forKey: "country_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if nameAr != nil{
            aCoder.encode(nameAr, forKey: "name_ar")
        }
        if nameEn != nil{
            aCoder.encode(nameEn, forKey: "name_en")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        
    }
    
}
