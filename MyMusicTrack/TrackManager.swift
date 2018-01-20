//
//  TrackManager.swift
//  MyMusicTrack
//
//
//  Copyright © 2017 xyx. All rights reserved.
//

import Foundation

class TrackManager {
    
    
public class func fetchMusicTracksMatching(trackSearch:String,completionBlock:@escaping (_ trackList:NSArray?,_ success:Bool)->Void) -> Void {
    //Creating the search api url with search string
    let musicURL = URL(string: "https://itunes.apple.com/search?term=\(trackSearch)")
    
    //Getting singleton instance og URLsession class
    let trackSession = URLSession.shared
    
    //Creating the async datatask to get the json Api response
    
    let trackTask = trackSession.dataTask(with: musicURL!) { (trackData, trackResponse, error) in
        
        do{
            //Json Serialization
            let tracks = try? JSONSerialization.jsonObject(with: trackData!, options: .mutableContainers) as! Dictionary<String, Any>
            
    
            guard let trackLists = tracks?["results"] as? NSArray else {
                
                //After async task success providing the call back to main thread to update the UI
                DispatchQueue.main.async {
                    completionBlock(nil,false)

                }
                return

            }
            var artists = Array<Any>()
            for track in trackLists {

                let trackModel:MMTrackModel = MMTrackModel(trackDetails: track as! Dictionary)
                artists.append(trackModel)
            }
            //After async task success providing the call back to main thread to update the UI
            DispatchQueue.main.async {
            completionBlock(artists as NSArray?,true)
            }
        }
        
    }
    //Using this to get the call back to the data task completion handler
    trackTask.resume()
    
    
}

    public class func fetchLyricsInfo(trackModel:MMTrackModel, completionBlock:@escaping (_ trackInfo:NSDictionary?,_ success:Bool)->Void) -> Void {

        let lyricsURL = URL(string: "http://lyrics.wikia.com/api.php?func=getSong&artist=\(trackModel.artistName.replacingOccurrences(of: " ", with: ""))&song=\(trackModel.trackName.replacingOccurrences(of: " ", with: ""))&fmt=json")
        
        //Getting singleton instance of URLsession class
        let lyricSession = URLSession.shared
        
//Creating the async datatask to get the json Api response
    
        
        
        
        let lyricsTask:Any = lyricSession.dataTask(with: lyricsURL!) { (lyricData, trackResponse, error) in
          
            do{
                //Json Serialization
                let tracks = try? JSONSerialization.jsonObject(with: lyricData!, options: .allowFragments)  as Any
                print(tracks)

                
            

            }
            
        }
(lyricsTask as AnyObject).resume()
}
}
