//
//  AvatarController.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

class AvatarController : UIViewController {
    
    private var _onAvatarChange : Callback<UIImage, Person>? = nil
    var person : Person? = nil {
        willSet {
            person?.avatar.fullImage.removeObserver(_onAvatarChange)
        }
        didSet {
            _onAvatarChange = person?.avatar.fullImage.addObserver({
                [weak self]
                (from: UIImage?, to: UIImage?, person: AnyObject) in
                guard person === self?.person else {
                    return
                }
                
                self?.avatarView?.image = self?.requestImage()
            })
        }
    }
    
    private var _loaderCache = URLTaskCache()
    
    private func requestImage() -> UIImage? {
        let image = person?.avatar.fullImage[]
        if nil == image {
            //Check whether a person is present and whether the avatar is not being loaded
            if (nil != person) && (nil == _loaderCache["ImageLoad"]) {
                let task = Github.getAvatar(forPerson: person!)
                _loaderCache["ImageLoad"] = task
            }
        }
        
        return image
    }
    
    @IBOutlet var avatarView : UIImageView? = nil
    
    @IBAction func dismiss() {
        UIView.animateWithDuration(0.25, animations: {
                [weak self] in
                self?.view.alpha = 0.0
            }, completion: {
                [weak self] 
                (finished: Bool) in
                self?.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        
        avatarView?.image = requestImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        _onAvatarChange?.unlink()
    }
}
