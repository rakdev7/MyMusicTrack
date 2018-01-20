//
//  MMTrackModel.swift
//  MyMusicTrack
//
//  Copyright © 2017 xyx. All rights reserved.
//

import Foundation

//Struct for Maintaining the Model of the Track
struct MMTrackModel {
    
    let trackName:String
    let artistName:String
    var albumName :String?
    let imageURL :String
    //Intailizer for the Model which can be used to parse the tracklsit json
    init(trackDetails:Dictionary<String,Any>) {
        self.trackName = trackDetails["trackName"] as! String
        self.artistName = trackDetails["artistName"] as! String
        self.albumName = trackDetails["collectionName"] as? String
        self.imageURL = trackDetails["artworkUrl30"] as! String
    }

}
