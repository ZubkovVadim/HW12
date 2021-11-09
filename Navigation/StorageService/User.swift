//
//  User.swift
//  Navigation
//
//  Created by Vadim on 21.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit


public class User {
    
    
   public var fullName: String = ""
   public var avatar = UIImage()
  public var status: String = ""

    init (fullName: String, avatar: UIImage, status: String) {
        self.fullName=fullName
        self.avatar=avatar
        self.status=status
    }
}



