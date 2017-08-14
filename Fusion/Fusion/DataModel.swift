//
//  DataModel.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 8/13/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import Foundation
import CoreData


class DataModel{
    static func addToWatchlist(contentID: String){
        let watchlist = NSEntityDescription.insertNewObject(forEntityName: "Watchlist", into: CoreDataStack.sharedCoreDataStack.persistentContainer.viewContext) as! Watchlist
        watchlist.userID = UserDataProvider.loggedInUser
        watchlist.contentID = contentID
        CoreDataStack.sharedCoreDataStack.saveContext()
    }
    
    static func getWatchlist() -> [String]?{
        var watchlist = [Watchlist]()
        var retWatchlist:[String]? = nil
        let watchlistFetchRequest = NSFetchRequest<Watchlist>(entityName: "Watchlist")
        watchlistFetchRequest.predicate = NSPredicate(format: "emailAddress == %@", UserDataProvider.loggedInUser!)
        do{
            //CoreDataStack.sharedCoreDataStack.persistentContainer.viewContext.has
            watchlist = try CoreDataStack.sharedCoreDataStack.persistentContainer.viewContext.fetch(watchlistFetchRequest)
            for item in watchlist{
                retWatchlist?.append(item.contentID!)
            }
            
        } catch let error{
            print(error)
        }
        return retWatchlist
    }
}
