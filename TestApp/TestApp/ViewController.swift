//
//  ViewController.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let USER_CHUNK_SIZE = 50
    
    @IBOutlet var tableView : UITableView? = nil
    
    var people : [Person] = []
    var maxCells : Int = USER_CHUNK_SIZE
    var taskCache : URLTaskCache = URLTaskCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if 0 == people.count {
            requestUsers(start: 0, count: ViewController.USER_CHUNK_SIZE)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

