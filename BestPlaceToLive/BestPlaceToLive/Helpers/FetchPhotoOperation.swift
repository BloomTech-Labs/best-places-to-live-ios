//
//  FetchPhotoOperation.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 12/6/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation
import UIKit

class FetchCityImageOperation: ConcurrentOperation {
    
    let imageURL: URL
    var image: UIImage?
    var dataTask: URLSessionDataTask?
    let session: URLSession
    
    init(imageURL: URL, session: URLSession = URLSession.shared) {
        self.imageURL = imageURL
        self.session = session
        super.init()
    }
    
    override func start() {
        state = .isExecuting
        let task = session.dataTask(with: imageURL) { (data, response, error) in
            defer { self.state = .isFinished }
            if self.isCancelled { return }
            if let error = error {
                NSLog("Error fetching data for image: \(error)")
                return
            }
            
            if let data = data {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
        dataTask = task
    }
    
    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
}
