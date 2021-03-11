//
//  LeagueDetailsPojo.swift
//  Sports App
//
//  Created by MacOSSierra on 2/20/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import Foundation
struct LeagueDetailsPojo: Codable {
    let leagues: [Leaguee]
}

// MARK: - League
struct Leaguee: Codable {
    let idLeague: String
    let strSport:String
    let strLeague: String
    let strYoutube: String
    let strBanner: String
    let strLogo: String
    let strNaming: String
    let strBadge:String
}


