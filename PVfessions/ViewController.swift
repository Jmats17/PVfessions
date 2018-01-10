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
    var ref : DatabaseReference!
    @IBOutlet var segmentedControl : UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference().child("confessions")
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.black
        refreshControl!.addTarget(self, action: #selector(ViewController.handleRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        observingDB()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func observingDB() {
        ref.observe(DataEventType.value, with: { (snapshot) in
            var newConfessions = [Confession]()
            for key in snapshot.children {
                let confession = Confession(snapshot: key as! DataSnapshot)
                newConfessions.append(confession)
            }
            self.confessions = []
            self.confessions = newConfessions
            self.tableView.reloadData()
            
        }) { (error : Error) in
            print(error)
        }
    }
    
    
    
    @IBAction func segmentedControl(_ segmentedControl : UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.confessions = []
            observingDB()
            self.tableView.reloadData()
        case 1:
            self.confessions = []
            observingDB()
            self.tableView.reloadData()
        default:
            break
        }
        
    }
    
    @IBAction func likeTapped(sender : UIButton) {
        let hitPoint = sender.convert(CGPoint.zero , to: self.tableView)
        let hitIndex = self.tableView.indexPathForRow(at: hitPoint)
        
       
    }

    @objc func handleRefresh() {
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
        if confession.henna != "" {
            cell.writtenByLabel.text = "\(confession.school!) , \"\(confession.henna!)\""
        }
        else {
            cell.writtenByLabel.text = "\(confession.school!), Anonymous"
        }

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return confessions.count
    }
}

extension UIImage {
    
}

