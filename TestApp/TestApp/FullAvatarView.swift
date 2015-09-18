//
//  AvatarView.swift
//  TestApp
//
//  Created by Serge Kutny on 9/18/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

class FullAvatarView : UIView {
    static let DEFAULT_MARGIN = 8.0
    
    @IBOutlet var picView : UIImageView? = nil
    @IBOutlet var dismissButton : UIButton? = nil
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin  = FullAvatarView.DEFAULT_MARGIN
        let bounds = Rect(self.bounds)
        var avatarFrame = Rect()
        let side = bounds.size.width - 2 * margin
        let left = bounds.origin.x + margin
        avatarFrame.size.width = side
        avatarFrame.size.height = side
        avatarFrame.origin.x = left
        avatarFrame.origin.y = bounds.origin.y + 0.5 * (bounds.size.height - side)
        
        picView?.frame = avatarFrame.OSRect()
        
        if let dismissFrame = dismissButton?.frame {
            var buttonFrame = Rect(dismissFrame)
            buttonFrame.size.width = side
            buttonFrame.origin.x = left
            buttonFrame.origin.y = bounds.origin.y + bounds.size.height
                - buttonFrame.size.height - FullAvatarView.DEFAULT_MARGIN
            
            dismissButton?.frame = buttonFrame.OSRect()
        }
    }
}
