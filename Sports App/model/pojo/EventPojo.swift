//
//  EventPojo.swift
//  Sports App
//
//  Created by MacOSSierra on 2/22/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import Foundation

struct EventPojo : Codable {
    let events : [Event]
    //let results : [Event]
}
struct Event : Codable {
    
    let dateEvent : String
    let idEvent : String
    let idLeague : String
    let intAwayScore : String
    let intHomeScore : String
    let strAwayTeam : String
    let strEvent : String
    let strHomeTeam : String
    let strLeague : String
    let strSeason : String
    let strSport : String
    let strTime : String
    let strTimeLocal : String
}

