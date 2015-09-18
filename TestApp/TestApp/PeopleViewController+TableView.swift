//
//  ViewController+TableView.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

extension PeopleViewController :
    UITableViewDataSource, UITableViewDelegate, AvatarViewer {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(people.count, maxCells)
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            if (indexPath.row == people.count - 1) {
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self?.requestNextUsers()
                })
            }
            
            guard indexPath.row < people.count else {
                let cell =
                    UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"Cell")
                cell.textLabel?.text = "Loading..."
                cell.textLabel?.textColor = UIColor.whiteColor()
                cell.contentView.backgroundColor = UIColor.blackColor()
                return cell
            }
            
            var cell : PersonCell? =
                tableView.dequeueReusableCellWithIdentifier("PersonCell") as? PersonCell
            if nil == cell {
                cell = PersonCell()
            }

            cell?.avatarViewDelegate = self
            
            let person = people[indexPath.row]
            cell?.person = person
            if nil == person.avatar.preview[] {
                Github.getAvatar(preview: true, forPerson: person)
            }
            
            return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    func viewAvatar(forPerson person: Person?) {
        contentOffset = tableView?.contentOffset ?? CGPointMake(0, 0)
        let viewer = AvatarController(nibName:"AvatarController", bundle:nil)
        viewer.person = person
        viewer.view.alpha = 0
        presentViewController(viewer, animated: false, completion: {
            UIView.animateWithDuration(0.25, animations: {
                viewer.view.alpha = 1.0
            })
        })
    }
}
