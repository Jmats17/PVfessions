//
//  Confession.swift
//  PVfessions
//
//  Created by Justin Matsnev on 3/13/17.
//  Copyright © 2017 PVfessions Inc. All rights reserved.
//


import Foundation
import FirebaseDatabase

class Confession {
    var story : String!
    var postedBy : String!
    var key : String!
    var storyRef : FIRDatabaseReference?
    
    init(key : String = "", story : String, postedBy : String) {
        self.key = key
        self.story = story
        self.postedBy = postedBy
    }
    
    init(snapshot : FIRDataSnapshot) {
        key = snapshot.key
        storyRef = snapshot.ref
        
        if let story = snapshot.childSnapshot(forPath: "story").value as? String {
            self.story = story
        }
        else {
            self.story = ""
        }
        
        if let postedBy = snapshot.childSnapshot(forPath: "postedBy").value as? String {
            self.postedBy = postedBy
        }
        else {
            self.postedBy = ""
        }
        
    }
}
