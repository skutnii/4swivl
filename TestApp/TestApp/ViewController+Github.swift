//
//  VieController+Github.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

extension ViewController : GithubDataConsumer {
    
    func receiveUsers(newPeople: [Person]) {
        people.appendContentsOf(newPeople)
        tableView?.reloadData()
    }
    
    func requestUsers(start start: Int, count: Int) {
       let loader = Github.getUsers(forConsumer: self, from: start, count: count)
       taskCache["LoadUsers(\(start),\(count))"] = loader
    }
    
    func requestNextUsers() {
        let count = ViewController.USER_CHUNK_SIZE
        maxCells = max(maxCells, people.count) + count
        requestUsers(start: people.count, count: count)

        tableView?.reloadData()
    }
}