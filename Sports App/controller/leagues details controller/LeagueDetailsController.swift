//
//  LeagueDetailsController.swift
//  Sports App
//
//  Created by MacOSSierra on 2/22/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

class LeagueDetailsController: UIViewController {
    var coreDataHandler = CoreDataHandler.shared
    
    @IBOutlet weak var eventResultTable: UITableView!
    
    @IBOutlet weak var eventsCollection: UICollectionView!
    @IBOutlet weak var teamsCollection: UICollectionView!
    @IBOutlet weak var saveBtn: UIButton!
    var isInFavorite = false
    var networkHandler = NetworkHandler();
    var currentLeague:Leaguee?
    var favLeague:NSManagedObject?
    var currentId = "";
    var selectedTeam:Team?;
    
    @IBAction func addToFavoriteAction(_ sender: Any) {
        if isInFavorite {
            let alert = UIAlertController(title: "delete", message: "are you want to delete from favorite?", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler:{action in
                self.isInFavorite = false;
                self.coreDataHandler.deleteObject(id: self.currentId)
                DispatchQueue.main.async {
                    self.saveBtn.setBackgroundImage(#imageLiteral(resourceName: "bookmark-2"), for: .normal);
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }else{
            if currentLeague != nil{
                coreDataHandler.insertData(object: currentLeague!)
            } else{
                coreDataHandler.insertData(object: favLeague!)
            }
            saveBtn.setBackgroundImage(nil, for: .normal)
            saveBtn.setBackgroundImage(#imageLiteral(resourceName: "bookmark"), for: .normal);
        }
        coreDataHandler.retriveData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        saveBtn.setBackgroundImage(#imageLiteral(resourceName: "bookmark-2"), for: .normal);
        coreDataHandler.delegate = self
        networkHandler.eventsDataDelegate = self
        networkHandler.teamsDataDelegate = self
        if let league = currentLeague {
            currentId = league.idLeague
            networkHandler.getAllEvent(leaueId: currentId )
            networkHandler.getTeamsInLeague(leagueName: league.strLeague)
        }else{
            currentId = favLeague!.value(forKey: "idLeague") as! String
            networkHandler.getAllEvent(leaueId: favLeague?.value(forKey: "idLeague") as! String)
            networkHandler.getTeamsInLeague(leagueName: favLeague?.value(forKey: "strLeague") as! String)
        }
        coreDataHandler.retriveData()
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension LeagueDetailsController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if Model.events.count == 0 {
            tableView.setEmptyMessage("there is no events, yet 🥺!")
        } else {
            tableView.restore()
        }
        
        return Model.events.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell" , for: indexPath) as! EventResultTableViewCell
        
        let homeTeamName = Model.events[indexPath.row].strHomeTeam;
        let awayTeamName = Model.events[indexPath.row].strAwayTeam;
        let homeScore:Int = Int(Model.events[indexPath.row].intHomeScore)!
        let awayScore:Int = Int(Model.events[indexPath.row].intAwayScore)!
        var homeUrl = "";
        var awayUrl = "";
        for i in Model.teams{
            if i.strTeam == homeTeamName{
                homeUrl = i.strTeamBadge!
            }
            if i.strTeam == awayTeamName{
                awayUrl = i.strTeamBadge!
            }
        }
        cell.dateLbl.text = Model.events[indexPath.row].dateEvent;
        cell.timeLbl.text = Model.events[indexPath.row].strTime;
        //cell.homeTeamLbl.text = homeTeamName
        //cell.awayTeamLbl.text = awayTeamName
        cell.homeScoreLbl.text = "\(homeScore)"
        cell.awayScoreLbl.text = "\(awayScore)"
        cell.homeTeamIv.sd_setImage(with: URL(string: homeUrl), placeholderImage:UIImage(named: "ea_sports"))
        cell.awayTeamIv.sd_setImage(with: URL(string: awayUrl), placeholderImage:UIImage(named: "ea_sports"))
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
}

extension LeagueDetailsController : UICollectionViewDelegate , UICollectionViewDataSource{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == eventsCollection{
            return Model.events.count;
        }else{
            return Model.teams.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.teamsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
            cell.teamLogoIv.sd_setImage(with: URL(string: (Model.teams[indexPath.row].strTeamBadge) ?? ""), placeholderImage: UIImage(named: "ea_sports"))
            return cell;
        }else{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCollectionViewCell;
            cell2.homeTeamLbl.text = Model.events[indexPath.row].strHomeTeam
            cell2.secondTeamLbl.text = Model.events[indexPath.row].strAwayTeam
            cell2.dateLbl.text = Model.events[indexPath.row].dateEvent
            cell2.timeLbl.text = Model.events[indexPath.row].strTime
            return cell2;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollection{
            selectedTeam = Model.teams[indexPath.row];
            self.performSegue(withIdentifier: "teamDetails", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "teamDetails"{
            let destination = segue.destination as! TeamDetailsController;
            destination.currentTeam = selectedTeam;
        }
        
    }
    
}


extension LeagueDetailsController : EventsDataDelegate{
    func didUpdateAllEvents(allEvents: EventPojo) {
        DispatchQueue.main.async {
            if allEvents.events != nil{
            Model.events = allEvents.events;
            self.eventResultTable.reloadData();
            self.eventsCollection.reloadData();
            }else{
                Model.events = [Event]() ;
                self.eventResultTable.reloadData();
                self.eventsCollection.reloadData();
            }
        }
    }
}

extension LeagueDetailsController : TeamsDataDelegate{
    func didUpdateTeama(teams: TeamPojo) {
        DispatchQueue.main.async {
            if teams.teams != nil{
                Model.teams=teams.teams!;
                self.teamsCollection.reloadData();
                self.eventResultTable.reloadData();
            }else {
                Model.teams=[Team]();
                self.teamsCollection.reloadData();
                self.eventResultTable.reloadData();
            }
           
        }
    }
    
}

extension LeagueDetailsController : FavoriteLeaguesDelegate{
    func didRetriveFavoriteLeague(league: [NSManagedObject]) {
        for i in league{
            if currentId == (i.value(forKey: "idLeague") as! String) {
                DispatchQueue.main.async {
                    self.saveBtn.setBackgroundImage(#imageLiteral(resourceName: "bookmark"), for: .normal);
                    self.isInFavorite = true
                }
                
            }
        }
    }
    
    
}
