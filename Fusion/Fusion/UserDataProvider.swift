//
//  UserDataProvider.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 7/31/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import Foundation
import CoreData
import SwiftKeychainWrapper


class UserDataProvider{
    static var user = [User]()
    static let loggedInUser = KeychainWrapper.standard.string(forKey: currentUser)
    
    static let userFetchRequest = NSFetchRequest<User>(entityName: "User")
    
    
    
    public static func getUserPhoto() -> UIImage{
        userFetchRequest.predicate = NSPredicate(format: "emailAddress == %@", loggedInUser!)
        do{
            user = try CoreDataStack.sharedCoreDataStack.persistentContainer.viewContext.fetch(userFetchRequest)
            return UIImage.init(data: (user.first?.userPhoto)!)!
        } catch let error{
            print(error)
        }
        return #imageLiteral(resourceName: "profile-photo-placeholder")
    }
    
    public static func getUserZipCode() -> String?{
        userFetchRequest.predicate = NSPredicate(format: "emailAddress == %@", loggedInUser!)
        do{
            user = try CoreDataStack.sharedCoreDataStack.persistentContainer.viewContext.fetch(userFetchRequest)
            return (user.first?.zipCode)!
        } catch let error{
            print(error)
        }
        return nil
    }
    
}
