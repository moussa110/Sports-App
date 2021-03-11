//
//  LeaguesController.swift
//  Sports App
//
//  Created by MacOSSierra on 2/20/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import UIKit
import SDWebImage

class LeaguesController: UITableViewController  {
    
    var networkHandler = NetworkHandler();
    var row:Int?
    var sportType:String?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkHandler.leaguesDataDelegate = self;
        networkHandler.getAllLeagues(sportType: sportType ?? "Soccre");
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if Model.leagues.count == 0{
            tableView.setEmptyMessage("waiting.....");
        }else{
            tableView.restore()
        }
        return Model.leagues.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell;
        
        cell.leagueNameLBL.text = Model.leagues[indexPath.row].strLeague;
        cell.leagueLogoIV.sd_setImage(with: URL(string: (Model.leagues[indexPath.row].strBadge)), placeholderImage: UIImage(named: "ea_sports"))
        cell.demoDelegate = self;
        cell.index = indexPath;
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row=indexPath.row;
        self.performSegue(withIdentifier: "showLeagueDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLeagueDetails"{
            let vc = segue.destination as! LeagueDetailsController;
            vc.currentLeague = Model.leagues[row!];
        }
    }
}

extension LeaguesController : LeaguesDataDelegate {
    func didUpdateLeagues(leagues: [Leaguee]) {
        Model.leagues = leagues
        self.tableView.reloadData();
        
    }
}


extension LeaguesController: DemoClickDelegate{
    func onClick(index: Int) {
        let url = URL(string:"http://\(Model.leagues[index].strYoutube)")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
