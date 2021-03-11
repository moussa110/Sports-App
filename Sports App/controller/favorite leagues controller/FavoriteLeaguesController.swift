//
//  FavoriteLeaguesController.swift
//  Sports App
//
//  Created by MacOSSierra on 2/25/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import UIKit
import CoreData
import Reachability
import SDWebImage

class FavoriteLeaguesController: UITableViewController {
    
    
    var networkHandler = NetworkHandler();
    var coreDataHandler = CoreDataHandler.shared;
    let reachability = try! Reachability()
    var isOnline = false;
    var row = 0;
    
    override func viewWillAppear(_ animated: Bool) {
        
        coreDataHandler.delegate = self;
        coreDataHandler.retriveData();
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if Model.favLeagues.count == 0{
            tableView.setEmptyMessage("There are no favorite leagues for you ...")
        }else{
            tableView.restore();
        }
        return Model.favLeagues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell
        
        cell.leagueNameLBL.text = Model.favLeagues[indexPath.row].value(forKey: "strLeague") as! String;
        cell.leagueLogoIV.sd_setImage(with: URL(string: (Model.favLeagues[indexPath.row].value(forKey: "strLogo") as! String)), placeholderImage: UIImage(named: "ball"))
        cell.demoDelegate = self;
        cell.index = indexPath;
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.coreDataHandler.deleteObject(id: Model.favLeagues[indexPath.row].value(forKey: "idLeague") as! String)
            Model.favLeagues.remove(at: indexPath.row);
            self.coreDataHandler.retriveData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //row=indexPath.row;
        if isOnline{
            
            row = indexPath.row
            self.performSegue(withIdentifier: "favDetails", sender: self)
        }else{
            showAlert()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favDetails"{
            let vc = segue.destination as! LeagueDetailsController;
            vc.favLeague = Model.favLeagues[row]
        }
    }
    
    
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            isOnline = true;
            print("Reachable via WiFi")
        case .cellular:
            isOnline = true;
            print("Reachable via Cellular")
        case .unavailable:
            isOnline = false
            print("Network not reachable")
        case .none:
            print("defult")        }
    }
    
    
    func showAlert(){
        let alert = UIAlertController(title: "Coneection", message: "check your network connection!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}



extension FavoriteLeaguesController : DemoClickDelegate{
    func onClick(index: Int) {
        if isOnline{
            let url = URL(string:"http://\(Model.favLeagues[index].value(forKey: "strYoutube")!)")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }else{
            showAlert()
        }
    }
    
    
}


extension FavoriteLeaguesController : FavoriteLeaguesDelegate{
    func didRetriveFavoriteLeague(league: [NSManagedObject]) {
        Model.favLeagues=league;
        DispatchQueue.main.async {
            self.tableView.reloadData();
        }
    }
}
