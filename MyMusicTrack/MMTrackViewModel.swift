//
//  TrackViewModel.swift
//  MyMusicTrack
//
//  Copyright © 2017 xyx. All rights reserved.
//

import UIKit

//Struct for Track View Model which can perform validation check for the nil album name value
struct MMTrackViewModel {
    
    let trackname:String
    let artistName:String
    let imageURL :String
  private  var _albumName:String=""
    //used to handle nil album names
    var albumName:String?{
        get {
          return _albumName
        }
        set {
            if let album = newValue {
                _albumName = album
            }
        }
    }
    
    //Intilaizer for struct which takes View model as argument which is used for implementing MVVVM design pattern
    init(trackDetails:MMTrackModel) {
        self.trackname = trackDetails.trackName
        self.artistName = trackDetails.artistName
        self.imageURL = trackDetails.imageURL
        
        albumName = trackDetails.albumName

    }
    
    
}
