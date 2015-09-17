//
//  GithubService.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import UIKit

protocol GithubDataConsumer : class {
    /*optional*/ func receiveUsers(_ : [Person])
}

extension GithubDataConsumer {
    func receiveUsers(_ : [Person]) {
        //Stub
    }
}

class Github : WebAPI {
    
    static let USERS_BASE : String = "https://api.github.com/users"
    static let PREVIEW_SIZE : Int = 100
    static let ERROR_DOMAIN = "Github API"
    
    static func getUsers(forConsumer consumer: GithubDataConsumer,
        from since: Int = 0, count per_page: Int = 20)  ->  NSURLSessionTask {
        
            let completeLink : String = "\(USERS_BASE)?since=\(since)&per_page=\(per_page)"
            let url: NSURL = NSURL(string: completeLink)!
            let request : NSURLRequest = NSURLRequest(URL: url)
            
            return doJSONDataRequest(request, dataHandler: {
                [weak consumer]
                (data: AnyObject?) in
                
                do {
                    guard nil != data else {
                        throw NSError(domain: ERROR_DOMAIN,
                            code:20000,
                            userInfo: [NSLocalizedDescriptionKey: "Github error: no data for users at \(completeLink)"]
                        )
                    }
                    
                    guard data is Array<Dictionary<String, AnyObject>> else {
                        throw NSError(domain: ERROR_DOMAIN,
                            code:20001 ,
                            userInfo: [NSLocalizedDescriptionKey: "Github error: unrecognized data format at \(completeLink)"]
                        )
                    }
                    
                    let values = data as! Array<Dictionary<String, AnyObject>>
                    var people : [Person] = []
                    for value in values {
                        let p: Person = Person()
                        p.updateWithData(value)
                        people.append(p)
                    }
                    
                    consumer?.receiveUsers(people)
                } catch let err as NSError {
                    NSLog(err.localizedDescription)
                }
            })
    }
    
    static func getAvatar(preview: Bool = false, forPerson person: Person)  ->  NSURLSessionTask? {
        guard let link = person.avatar.link else {
            return nil
        }
        
        let completeLink = link + (preview ? "&s=\(PREVIEW_SIZE)" : "")

        let url: NSURL = NSURL(string: completeLink)!
        let request : NSURLRequest = NSURLRequest(URL: url)
        return doDownload(request: request, handler: {
            [weak person]
            (url: NSURL?) in
            do {
                guard nil != url else {
                    throw NSError(domain: ERROR_DOMAIN,
                        code: 20000,
                        userInfo:[NSLocalizedDescriptionKey: "Github error: no avatar data at \(completeLink)"]
                    )
                }
                
                let data : NSData? = NSData(contentsOfURL: url!)
                guard nil != data else {
                    throw NSError(domain: ERROR_DOMAIN,
                        code: 20002,
                        userInfo:[NSLocalizedDescriptionKey: "Github error: unreadable data at \(url)"]
                    )
                }
                
                let image: UIImage? = UIImage(data: data!)
                guard nil != image else {
                    throw NSError(domain: ERROR_DOMAIN,
                        code: 20003,
                        userInfo:[NSLocalizedDescriptionKey:
                            "Github error: could not create image from downloaded data at \(url)"]
                    )
                }
                
                if preview {
                    person?.avatar.preview = image
                } else {
                    person?.avatar.fullImage = image
                }
            } catch let err as NSError {
                NSLog(err.localizedDescription)
            }
        })
    }
}
