//
//  PersonCell.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

protocol AvatarViewer : class {
    func viewAvatar(forPerson person:Person?) -> ()
}

class PersonCell : UITableViewCell {
    @IBOutlet var avatarView : UIImageView? = nil
    @IBOutlet var nameLabel : UILabel? = nil
    @IBOutlet var profileLabel : UILabel? = nil
    @IBOutlet var infoView : UITextView? = nil
    @IBOutlet var avatarOverlay : UIView? = nil {
        didSet {
            if nil != avatarOverlay {
                avatarOverlay!.addGestureRecognizer(UITapGestureRecognizer(target:self,  action:(NSSelectorFromString("viewAvatar"))))
            }
        }
    }
    
    weak var avatarViewDelegate : AvatarViewer? = nil
    
    @IBAction func viewAvatar() {
        avatarViewDelegate?.viewAvatar(forPerson: self.person)
    }
    
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
        let name = NSMutableAttributedString(string: person?.login ?? "")
        let link = NSMutableAttributedString(string:person?.profileLink ?? "")
        
        name.setAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(20.0),
            NSForegroundColorAttributeName: UIColor.whiteColor()], range: NSMakeRange(0, name.length))
        
        link.setAttributes([NSFontAttributeName: UIFont.systemFontOfSize(16.0)], range: NSMakeRange(0, link.length))
        
        let text = NSMutableAttributedString(string:"")
        text.appendAttributedString(name)
        text.appendAttributedString(NSAttributedString(string:"\n\n"))
        text.appendAttributedString(link)
        
        avatarView?.image = self.person?.avatar.preview[]
        self.infoView?.attributedText = text
    }
}
