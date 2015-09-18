//
//  VieController+Github.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

extension PeopleViewController : GithubDataConsumer {
    
    func receiveUsers(newPeople: [Person]) {
        let start = people.count
        let end = start + newPeople.count
        people.appendContentsOf(newPeople)
        tableView?.reloadData()
    }
    
    func requestUsers(start start: Int, count: Int) {
        let taskId = "LoadUsers(\(start),\(count))"
        
        //No need to add a new task if one is already present, just sit and wait
        guard nil == taskCache[taskId] else {
            return
        }
        
        let loader = Github.getUsers(forConsumer: self, from: start, count: count)
        taskCache[taskId] = loader
    }
    
    func requestNextUsers() {
        let count = PeopleViewController.USER_CHUNK_SIZE
        let addPoint = people.count
        maxCells = max(maxCells, addPoint) + count
        requestUsers(start: addPoint, count: count)

        tableView?.reloadData()
    }
}