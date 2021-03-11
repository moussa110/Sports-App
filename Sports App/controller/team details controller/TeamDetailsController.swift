//
//  TeamDetailsController.swift
//  Sports App
//
//  Created by MacOSSierra on 3/5/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import UIKit

class TeamDetailsController: UIViewController , UITableViewDelegate ,UITableViewDataSource {
    @IBOutlet weak var viewCom: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var imgBadge: UIImageView!
    @IBOutlet weak var imgShirt: UIImageView!
    @IBOutlet weak var strTeamLbl: UILabel!
    @IBOutlet weak var strAlternativeLbl: UILabel!
    @IBOutlet weak var formedYearLbl: UILabel!
    @IBOutlet weak var competittionsLbl: UILabel!
    var networkHandler = NetworkHandler();
    var currentTeam:Team?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkHandler.latestEventsDelegete = self;
        networkHandler.getLatestEventToTeam(teamId: (currentTeam?.idTeam!)!)
        
        strTeamLbl.text = currentTeam?.strTeam!;
        if currentTeam?.strAlternate == nil || currentTeam?.strAlternate == ""{
            strAlternativeLbl.text = "no alternate";
        }else{
            strAlternativeLbl.text = currentTeam?.strAlternate
        }
        
        var competittionsStr = "";
        
        if(currentTeam?.strLeague != nil){
            competittionsStr = "1- \(currentTeam!.strLeague!)\n";
        }else{
            competittionsStr = "no current competittions !"
        }
        if(currentTeam?.strLeague2 != nil){
            competittionsStr.append("2- \(currentTeam!.strLeague2!)\n")
        }
        if(currentTeam?.strLeague3 != nil){
            competittionsStr.append("3- \(currentTeam!.strLeague3!)\n")
        }
        if(currentTeam?.strLeague4 != nil){
            competittionsStr.append("4- \(currentTeam!.strLeague4!)\n")
        }
        
        
       
        
        competittionsLbl.text = competittionsStr;
        imgCover.sd_setImage(with: URL(string: currentTeam?.strStadiumThumb ?? ""), placeholderImage:UIImage(named: "stadium"))
        imgBadge.sd_setImage(with: URL(string: currentTeam?.strTeamBadge ?? ""), placeholderImage:UIImage(named: "ea_sports"))
        imgShirt.sd_setImage(with: URL(string: currentTeam?.strTeamJersey ?? ""), placeholderImage:UIImage(named: "shirt"))
        
        self.viewCom.layer.cornerRadius = 13
        self.viewCom.clipsToBounds = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Model.latestEvents.count == 0 {
            tableView.setEmptyMessage("there is no events, yet 🥺!")
        } else {
            tableView.restore()
        }
        
        return Model.latestEvents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell" , for: indexPath) as! EventResultTableViewCell
        
        var homeTeamName =  Model.latestEvents[indexPath.row].strHomeTeam ?? "No Name";
        let awayTeamName =  Model.latestEvents[indexPath.row].strAwayTeam ?? "No Name";
        let homeScore:Int = Int( Model.latestEvents[indexPath.row].intHomeScore ?? "0")!
        let awayScore:Int = Int( Model.latestEvents[indexPath.row].intAwayScore ?? "0")!
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
        cell.dateLbl.text =  Model.latestEvents[indexPath.row].dateEvent ;
        cell.timeLbl.text =  Model.latestEvents[indexPath.row].strTime;
        //cell.homeTeamLbl.text = homeTeamName
        //cell.awayTeamLbl.text = awayTeamName
        cell.homeScoreLbl.text = "\(homeScore)"
        cell.awayScoreLbl.text = "\(awayScore)"
        cell.homeTeamIv.sd_setImage(with: URL(string: homeUrl), placeholderImage:UIImage(named: "ea_sports"))
        cell.awayTeamIv.sd_setImage(with: URL(string: awayUrl), placeholderImage:UIImage(named: "ea_sports"));
        
        return cell
    }
    

}

extension TeamDetailsController : LatestEventsDelegate{
    func didUpdateEvents(events: [Result]?) {
        DispatchQueue.main.async {
            if events != nil{
            Model.latestEvents = events!;
            self.tableView.reloadData();
            }else{
               Model.latestEvents = [Result]();
                self.tableView.reloadData();
            }
            
        }
    }
}
