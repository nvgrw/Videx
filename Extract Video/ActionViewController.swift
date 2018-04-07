//
//  ActionViewController.swift
//  Extract Video
//
//  Created by Nik on 07/04/2018.
//  Copyright © 2018 nik. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var videos: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = self.extensionContext!.inputItems.first as! NSExtensionItem
        let provider = item.attachments?.first as! NSItemProvider
        
        provider.loadItem(
            forTypeIdentifier: kUTTypePropertyList as String, options: nil)
            { (dictionary, error) in
                guard let dic = dictionary as? NSDictionary,
                    let javascript = dic.object(forKey: NSExtensionJavaScriptPreprocessingResultsKey) as? NSDictionary,
                    let videos = javascript.object(forKey: "videos") as? [String] else {
                    self.exit(error: error.localizedDescription)
                    return;
                }
            
                self.videos = videos
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .filter { !$0.isEmpty }
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel() {
        exit(withValues: ["success": "cancel"])
    }
}

// MARK: - Exit Functions
extension ActionViewController {
    fileprivate func exit(error message: String) {
        exit(withValues: ["success": "false", "message": message])
    }
    
    fileprivate func exit(redirectTo url: String) {
        exit(withValues: ["success": "true", "url": url])
    }
    
    fileprivate func exit(withValues values: [String: String]) {
        OperationQueue.main.addOperation {
            let item = NSExtensionItem()
            let status = [NSExtensionJavaScriptFinalizeArgumentKey : values]
            item.attachments = [NSItemProvider(item: status as NSSecureCoding,
                                               typeIdentifier: kUTTypePropertyList as String)]
            self.extensionContext!.completeRequest(returningItems: [item], completionHandler: nil)
        }
    }
}

extension ActionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = videos[indexPath.row]
        return cell
    }
}

extension ActionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        exit(redirectTo: videos[indexPath.row])
    }
}
