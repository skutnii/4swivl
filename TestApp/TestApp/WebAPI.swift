//
//  WebAPI.swift
//  TestApp
//
//  Created by Serge Kutny on 9/17/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

import Foundation

class WebAPI {

    private static let session : NSURLSession =
        NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    static func doJSONDataRequest(request: NSURLRequest,
        dataHandler: (_ : AnyObject?) -> ()) -> NSURLSessionTask {
         return session.dataTaskWithRequest(request,
            completionHandler:  {
                (data: NSData?, response: NSURLResponse?, error: NSError?) in
                do {
                    guard nil == error else {
                        throw error!
                    }
                    
                    guard nil != data else {
                        throw NSError(domain: "", code: 10000,
                            userInfo: [NSLocalizedDescriptionKey: "No data returned from URL \(request.URL)"])
                    }
                    
                    let parsedData =
                    try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                    
                    dataHandler(parsedData)
                    
                } catch let err as NSError {
                    dataHandler(nil)
                    NSLog(err.localizedDescription)
                } catch {
                    dataHandler(nil)
                    NSLog("Unknown error when loading \(request.URL)")
                }
            }
        )
    }
    
    static func doDownload(request request: NSURLRequest,
        handler dataHandler: (NSURL?) -> ()) -> NSURLSessionTask {
        return session.downloadTaskWithRequest(request, completionHandler: {
            (location: NSURL?, response: NSURLResponse?, error: NSError?) in
            
            guard nil == error else {
                dataHandler(nil)
                NSLog(error!.localizedDescription)
                return
            }
            
            dataHandler(location)
        })
    }
    
}
