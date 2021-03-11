//
//  SportsPojo.swift
//  Sports App
//
//  Created by MacOSSierra on 2/18/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import Foundation
struct SportsPojo: Codable {
    let sports: [Sport]
}

// MARK: - Sport
struct Sport: Codable {
    let idSport:String
    let strSport: String
    let strFormat: String
    let strSportThumb:String
    let strSportThumbGreen: String
}


