//
//  MMTMasterTrackViewController.swift
//  MyMusicTrack
//
//  Copyright © 2017 xyx. All rights reserved.
//

import UIKit

class MMTMasterTrackViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    var listofTracks:Array<Any>?
    @IBOutlet weak var artistSearchBar: UISearchBar!
    @IBOutlet var tracksTableView:UITableView?


    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = self.listofTracks?.count else {
            return 0
        }
        return rows
    }

 
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trackModel:MMTrackModel = self.listofTracks![indexPath.row] as! MMTrackModel
        let cell:TrackCell = tableView.dequeueReusableCell(withIdentifier: "Track", for: indexPath) as! TrackCell
        
        let trackVModel:MMTrackViewModel = MMTrackViewModel(trackDetails: trackModel)
        cell.artistName.text = trackVModel.artistName
        cell.trackName.text = trackVModel.trackname
        cell.albumName.text = trackVModel.albumName
        
        do {
            let imageData = try Data(contentsOf: URL(string: trackVModel.imageURL)!)
            cell.trackImageView.image = UIImage(data: imageData)
        }
        catch _ {
        
        }

        return cell
    }
    
    //Mark: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let trackViewModel = self.listofTracks?[indexPath.row] as! MMTrackModel
        TrackManager.fetchLyricsInfo(trackModel: trackViewModel) { (lyricsInfo, success) in
            
        }
        
        
    }
    
    
    
    
    // MARK: -Search Bar delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    
        let trimmedString = searchBar.text?.replacingOccurrences(of: " ", with: "")
        
        TrackManager.fetchMusicTracksMatching(trackSearch: trimmedString!) { (list, success) in
            
            if(success){
                self.listofTracks = list as! Array<Any>?
                self.tracksTableView?.reloadData()
                
            }
        }
    
        
        
        
    
    
    }
}
