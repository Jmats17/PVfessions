//
//  ViewController.swift
//  PVfessions
//
//  Created by Justin Matsnev on 3/12/17.
//  Copyright © 2017 PVfessions Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    let popupView = PopupViewController()
    var confessions = [Confession]()
    var refreshControl: UIRefreshControl!
    var circle : Confession? = nil
    var ref : FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ref = FIRDatabase.database().reference().child("confessions")
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.black
        refreshControl!.addTarget(self, action: #selector(ViewController.handleRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        observingDB()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func observingDB() {
        ref.observe(FIRDataEventType.value, with: { (snapshot) in
            var newConfessions = [Confession]()
            for key in snapshot.children {
                let confession = Confession(snapshot: key as! FIRDataSnapshot)
                newConfessions.append(confession)
            }
            self.confessions = []
            self.confessions = newConfessions
            self.tableView.reloadData()
            
        }) { (error : Error) in
            print(error)
        }
    }

    func handleRefresh() {
        observingDB()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newStory() {
        popupView.showPopup(.centered)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfessionCell", for: indexPath) as! ConfessionTableViewCell
        let confession = confessions[(indexPath as NSIndexPath).row]
        print(confession)
        cell.storyTextLabel.text = confession.story
        cell.writtenByLabel.text = "\(confession.school!) - \"\(confession.henna!)\""

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return confessions.count
    }
}

