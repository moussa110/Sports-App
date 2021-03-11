//
//  LatestEventForTeamPojo.swift
//  Sports App
//
//  Created by MacOSSierra on 3/6/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import Foundation

struct LatestEventForTeamPojo: Codable {
    let results : [Result]?
}

struct Result : Codable {
    
    let dateEvent : String
    let dateEventLocal : String?
    let idAPIfootball : String?
    let idAwayTeam : String?
    let idEvent : String?
    let idHomeTeam : String?
    let idLeague : String?
    let intAwayScore : String?
    let intHomeScore : String?
    let intRound : String?
    let strAwayGoalDetails : String?
    let strAwayTeam : String?
    let strCity : String?
    let strCountry : String?
    let strDescriptionEN : String?
    let strEvent : String?
    let strEventAlternate : String?
    let strFilename : String?
    let strHomeGoalDetails : String?
    let strHomeTeam : String?
    let strLeague : String?
    let strLocked : String?
    let strOfficial : String?
    let strPostponed : String?
    let strResult : String?
    let strSeason : String?
    let strSport : String?
    let strStatus : String?
    let strThumb : String?
    let strTime : String?
    let strTimeLocal : String?
    let strTimestamp : String?
    let strTweet1 : String?
    let strTweet2 : String?
    let strTweet3 : String?
    let strVenue : String?
    let strVideo : String?
}



