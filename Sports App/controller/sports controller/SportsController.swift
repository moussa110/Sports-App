//
//  SportsController.swift
//  Sports App
//
//  Created by MacOSSierra on 2/18/21.
//  Copyright © 2021 mousa. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "sportCell"
class SportsController: UICollectionViewController {
    var networkHandler=NetworkHandler();
    var sportType:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkHandler.sportsDataDelegate = self;
        networkHandler.getAllSports();
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (Model.sports.count) ;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SportsViewCell
        
        cell.strSportLbl.text = Model.sports[indexPath.row].strSport;
        cell.imgSport.sd_setImage(with: URL(string: (Model.sports[indexPath.row].strSportThumb)), placeholderImage: UIImage(named: "sports_icon"))
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sportType = Model.sports[indexPath.row].strSport;
        self.performSegue(withIdentifier: "showLeague", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLeague"{
            let destination = segue.destination as! LeaguesController;
            destination.sportType = sportType;
        }
    }
}

extension SportsController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width-12)/2
        return CGSize(width: width, height: width)
    }
}


extension SportsController :SportsDataDelegate{
    func didUpdateAllSports(allSports: SportsPojo) {
        DispatchQueue.main.async {
            Model.sports = allSports.sports
            self.collectionView.reloadData();
        }
    }
}
