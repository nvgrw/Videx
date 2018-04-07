//
//  ActionRequestHandler.swift
//  Picture in Picture
//
//  Created by Nik on 07/04/2018.
//  Copyright © 2018 nik. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionRequestHandler: NSObject, NSExtensionRequestHandling {
    
    func beginRequest(with context: NSExtensionContext) {
        
        let item = context.inputItems.first as! NSExtensionItem
        let provider = item.attachments?.first as! NSItemProvider
        
        provider.loadItem(forTypeIdentifier: kUTTypePropertyList as String,
                          options: nil) { (data, error) in
            context.completeRequest(returningItems: [], completionHandler: nil)
        }
    }

}
