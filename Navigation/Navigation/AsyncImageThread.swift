//
//  AsyncImageThread.swift
//  Navigation
//
//  Created by Vadim on 29.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit
import StorageService
import iOSIntPackage

class AsyncImageProcessor : Thread {
    private let posts : [PostModel]
    private var asyncResult : [UIImage?]
    private let userHandler: ([UIImage?]) -> Void
    
    init(posts : [PostModel], asyncResult: [UIImage], completion : @escaping ([UIImage?]) -> Void) {
        self.posts = posts
        self.asyncResult = Array(repeating: nil, count: posts.count)
        self.userHandler = completion
        super .init()
    }
    override func main() {
        var imagesInThread : [UIImage] = []
        for post in self.posts {
            if let image = UIImage(named: post.image) {
                imagesInThread.append(image)
            }
        }
        ImageProcessor().processImagesOnThread(sourceImages: imagesInThread,
                                               filter: ColorFilter.allCases.randomElement()!,
                                               qos : .default){
            (results : [CGImage?]) in
            
            for (index, indexImage) in results.enumerated() {
                if let image = indexImage {
                    self.asyncResult[index] = UIImage(cgImage: image)
                }
            }
            
            self.userHandler(self.asyncResult)
        }
    }
}
