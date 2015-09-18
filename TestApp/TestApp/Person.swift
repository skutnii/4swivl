//
//  Person.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

class Person {
    var login : String? = nil
    var profileLink : String? = nil
    
    class Avatar {
        
        var link: String? = nil
        
        var preview: Observable<UIImage, Person>
        var fullImage: Observable<UIImage, Person>
        
        unowned let owner : Person
        
        init?(creator: Person?) {
            owner = creator!
            
            preview = Observable<UIImage, Person>(owner: owner, value: nil)
            fullImage = Observable<UIImage, Person>(owner: owner, value: nil)
            
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


