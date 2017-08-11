//
//  MiscDataProvider.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 8/11/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import Foundation

class MiscDataProvider{
    static var TMDB_API_Key = String()
    
    
    //get the API key from the plist file
    static func retrieveAPIKey(){
        guard let path = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
            fatalError("APIKey plist not found")
        }
        let data = FileManager.default.contents(atPath: path)
        var format = PropertyListSerialization.PropertyListFormat.xml
        do{
            let apiDict = try PropertyListSerialization.propertyList(from: data!, options: [], format: &format) as! [String:Any]
            TMDB_API_Key = apiDict["TMDB API"] as! String
        } catch let error{
            print(error)
        }
    }
}
