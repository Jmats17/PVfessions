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
    var school : String!
    var henna : String!
    var key : String!
    var storyRef : FIRDatabaseReference?
    
    init(key : String = "", story : String, school : String, henna : String) {
        self.key = key
        self.story = story
        self.school = school
        self.henna = henna

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
        
        if let school = snapshot.childSnapshot(forPath: "school").value as? String {
            self.school = school
        }
        else {
            self.school = ""
        }
        
        if let henna = snapshot.childSnapshot(forPath: "henna").value as? String {
            self.henna = henna
        }
        else {
            self.henna = ""
        }
    }
}
