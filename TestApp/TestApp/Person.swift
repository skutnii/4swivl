//
//  Person.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

protocol PersonDelegate {
    func avatarPreviewDidChange(person: Person)
    func fullAvatarDidChange(person: Person)
}

class Person {
    var login : String? = nil
    var profileLink : String? = nil
    
    var delegate : PersonDelegate?
    
    class Avatar {
        
        var link: String? = nil
        
        var preview: UIImage? = nil {
            didSet {
                owner.delegate?.avatarPreviewDidChange(owner)
            }
        }
        
        var fullImage: UIImage? = nil {
            didSet {
                owner.delegate?.fullAvatarDidChange(owner)
            }
        }
        
        unowned let owner : Person
        
        init?(creator: Person?) {
            owner = creator!
            
            if nil == creator {
                return nil
            }
        }
    }
    
    var avatar: Avatar!
    
    init() {
        avatar = Avatar(creator: self)
    }
    
    func updateWithData(data: [String: AnyObject]) {
        login = data["login"] as? String
        profileLink = data["html_url"] as? String
        avatar.link = data["avatar_url"] as? String
    }
}


