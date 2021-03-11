//
//  Model.swift
//  Sports App
//
//  Created by MacOSSierra on 3/3/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import Foundation
import CoreData
class Model{
    
    static var sports:[Sport] = [Sport]();
    static var leagues:[Leaguee] = [Leaguee]();
    static var favLeagues = [NSManagedObject]();
    static var events = [Event]();
    static var latestEvents = [Result]();
    static var teams = [Team]();
    static var currentLeague:Leaguee?
}
