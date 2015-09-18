//
//  PeopleContainerView.swift
//  TestApp
//
//  Created by Serge Kutny on 9/18/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

class PeopleContainerView : UIView {
    @IBOutlet var contentView : UITableView? = nil
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView?.frame = self.bounds
    }
}
