//
//  PeopleViewController.swift
//  TestApp
//
//  Created by Serge Kutny on 9/18/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

@objc class PeopleViewController: UIViewController {
    
    static let USER_CHUNK_SIZE = 50
    
    @IBOutlet var tableView : UITableView? = nil
    
    var people : [Person] = []
    var maxCells : Int = USER_CHUNK_SIZE
    var taskCache : URLTaskCache = URLTaskCache()
    
    var contentOffset : CGPoint = CGPointMake(0, 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.registerNib(UINib(nibName:"PersonCell", bundle:nil), forCellReuseIdentifier:"PersonCell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView?.setContentOffset(contentOffset, animated:false)
        if 0 == people.count {
            requestUsers(start: 0, count: PeopleViewController.USER_CHUNK_SIZE)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

