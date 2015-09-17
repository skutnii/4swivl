//
//  PersonCell.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

class PersonCell : UITableViewCell {
    @IBOutlet var avatarView : UIImageView? = nil
    @IBOutlet var nameLabel : UILabel? = nil
    @IBOutlet var profileLabel : UILabel? = nil
    
    private var _onAvatarChange : Callback<UIImage, Person>? = nil
    var person : Person? = nil {
        willSet {
            person?.avatar.preview.removeObserver(_onAvatarChange)
        }
        didSet {
            _onAvatarChange = person?.avatar.preview.addObserver({
                    [weak self]
                    (from: UIImage?, to: UIImage?, person: AnyObject) in
                    guard person === self?.person else {
                        return
                    }
                
                    self?.layoutSubviews()
                })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel?.text = person?.login ?? ""
        profileLabel?.text = person?.profileLink ?? ""
        avatarView?.image = self.person?.avatar.preview[]
    }
}
