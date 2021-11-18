//
//  PhotosPublisher.swift
//  Navigation
//
//  Created by Vadim on 07.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit
import StorageService
import iOSIntPackage
protocol MyViewControllerOutput: AnyObject {
    func configurePublisher()
    func cancelSubscription()
}

class PhotosPublisher: MyViewControllerOutput {

    
    
    private let publisher = ImagePublisherFacade()
    
    func configurePublisher() {
        publisher.subscribe(self)
        let initialImages = PhotosStorage.photos.compactMap { UIImage(named: $0.image) }
        publisher.addImagesWithTimer(time: 5,
                                     repeat: 10,
                                     userImages: initialImages)
    }
    func cancelSubscription() {
        publisher.rechargeImageLibrary()
        publisher.removeSubscription(for: self)
    }
}
extension PhotosPublisher: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        let images = images
    }
}
