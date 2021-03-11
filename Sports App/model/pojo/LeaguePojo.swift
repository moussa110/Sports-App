//
//  LeaguePojo.swift
//  Sports App
//
//  Created by MacOSSierra on 2/20/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import Foundation
struct LeaguePojo: Codable {
    let leagues: [League]
}

// MARK: - League
struct League: Codable {
    let idLeague: String
    let strLeague: String
    let strSport: String
    let strLeagueAlternate: String?
}
