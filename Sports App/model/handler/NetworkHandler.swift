//
//  NetworkHandler.swift
//  Sports App
//
//  Created by MacOSSierra on 2/18/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import Foundation
import Alamofire

protocol SportsDataDelegate {
    func didUpdateAllSports(allSports : SportsPojo);
}

protocol EventsDataDelegate {
    func didUpdateAllEvents(allEvents : EventPojo);
}

protocol LeaguesDataDelegate {
    func didUpdateLeagues(leagues : [Leaguee]);
}

protocol TeamsDataDelegate {
    func didUpdateTeama(teams : TeamPojo);
}

protocol LatestEventsDelegate {
    func didUpdateEvents(events : [Result]?);
}

struct NetworkHandler{
    
    
    
    var sportsDataDelegate:SportsDataDelegate?;
    var leaguesDataDelegate:LeaguesDataDelegate?;
    var eventsDataDelegate:EventsDataDelegate?;
    var teamsDataDelegate:TeamsDataDelegate?;
    var latestEventsDelegete:LatestEventsDelegate?;
    var leaguesData = [LeagueDetailsPojo]();
    
    func getAllSports() {
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
        let request = AF.request(urlString);
        request.responseDecodable(of: SportsPojo.self){ (response) in
            if let data = response.value{
                self.sportsDataDelegate?.didUpdateAllSports(allSports: data)
            }
        }
    }
    
    func getAllLeagues(sportType:String) {
        var arr = [String]();
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php"
        let request = AF.request(urlString);
        request.responseDecodable(of: LeaguePojo.self){ (response) in
            if let data = response.value{
                // arr = data.leagues;
                for i in data.leagues
                {
                    if i.strSport == sportType{
                        arr.append(i.idLeague)
                    }
                }
                print("arrsss\(arr.count)")
                self.getLeaguesDetails(ar: arr);
            }
        }
    }
    
    func getLeaguesDetails(ar: [String]) {
        var arr = [Leaguee]();
        for id in ar{
            let urlString = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=\(id)"
            let request = AF.request(urlString);
            request.responseDecodable(of: LeagueDetailsPojo.self){ (response) in
                if let data = response.value{
                    arr.append(data.leagues[0])
                    self.leaguesDataDelegate?.didUpdateLeagues(leagues: arr)
                }
            }
        }
    }
    
    func getTeamsInLeague(leagueName: String) {
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=\(leagueName)"
        let replaced = urlString.replacingOccurrences(of: " ", with: "%20")
        print(replaced)
        let request = AF.request(replaced);
        request.responseDecodable(of:TeamPojo.self){ (response) in
            if let data = response.value{
                self.teamsDataDelegate?.didUpdateTeama(teams: data);
            }
        }
    }
    
    func getAllEvent(leaueId : String){
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=\(leaueId)"
        let request = AF.request(urlString);
        request.responseDecodable(of: EventPojo.self){ (response) in
            if let data = response.value{
                self.eventsDataDelegate?.didUpdateAllEvents(allEvents: data);
            }
        }
    }

    func getLatestEventToTeam(teamId :String){
        let urlString = "https://www.thesportsdb.com/api/v1/json/1/eventslast.php?id=\(teamId)"
        let request = AF.request(urlString);
        request.responseDecodable(of: LatestEventForTeamPojo.self){ (response) in
            if let data = response.value{
                self.latestEventsDelegete?.didUpdateEvents(events: data.results)
            }
        }
    }
}
