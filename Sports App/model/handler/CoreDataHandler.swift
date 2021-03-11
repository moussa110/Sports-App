//
//  CoreDataHandler.swift
//  Sports App
//
//  Created by MacOSSierra on 2/25/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol FavoriteLeaguesDelegate {
    func didRetriveFavoriteLeague(league : [NSManagedObject])
}

struct CoreDataHandler {
    static let shared = CoreDataHandler();
    private var appDelgete:AppDelegate;
    var  delegate:FavoriteLeaguesDelegate?;
    
    private init(){
        appDelgete = UIApplication.shared.delegate as! AppDelegate;
    }
    
    func insertData(object : Leaguee)  {
        let manageContext = appDelgete.persistentContainer.viewContext;
        let enteity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: manageContext);
        let favLeague = NSManagedObject(entity: enteity!, insertInto: manageContext);
        
        favLeague.setValue(object.idLeague, forKey: "idLeague")
        favLeague.setValue(object.strLeague, forKey: "strLeague")
        favLeague.setValue(object.strSport, forKey: "strSport")
        favLeague.setValue(object.strBadge, forKey: "strLogo")
        favLeague.setValue(object.strYoutube, forKey: "strYoutube")
        
        do{
            try manageContext.save();
        }catch let error{
            print(error)
        }
    }
    
    func insertData(object : NSManagedObject)  {
        let manageContext = appDelgete.persistentContainer.viewContext;
        let enteity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: manageContext);
        let favLeague = NSManagedObject(entity: enteity!, insertInto: manageContext);
        
        favLeague.setValue(object.value(forKey: "idLeague"), forKey: "idLeague")
        favLeague.setValue(object.value(forKey: "strLeague"), forKey: "strLeague")
        favLeague.setValue(object.value(forKey: "strSport"), forKey: "strSport")
        favLeague.setValue(object.value(forKey: "strLogo"), forKey: "strLogo")
        favLeague.setValue(object.value(forKey: "strYoutube"), forKey: "strYoutube")
        
        do{
            try manageContext.save();
        }catch let error{
            print(error)
        }
    }
    
    
    func deleteObject(id:String){
        var leaguesArray=[NSManagedObject]();
        
        let manageContext = appDelgete.persistentContainer.viewContext;
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague");
        
        let predicate = NSPredicate(format: "idLeague = %@", id)
        fetchRequest.predicate = predicate
        
        do{
            leaguesArray = try manageContext.fetch(fetchRequest);
        }catch let error{
            print(error)
        }
        
        for object in leaguesArray {
            manageContext.delete(object)
        }
    }
    
    func retriveData() {
        var leaguesArray=[NSManagedObject]();
        
        let manageContext = appDelgete.persistentContainer.viewContext;
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague");
        
        do{
            leaguesArray = try manageContext.fetch(fetchRequest);
            self.delegate?.didRetriveFavoriteLeague(league: leaguesArray)
        }catch let error{
            print(error)
        }
    }
}
