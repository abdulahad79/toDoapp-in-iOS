//
//  Chatmodel.swift
//  todoAppFB
//
//  Created by abdul ahad on 09/03/2019.
//  Copyright © 2019 abdul ahad. All rights reserved.
//

import Foundation
import UIKit

class Chatmodel {
    var id: String?
    var name: String?
    var cost: String?
    var location: String?
    var description: String?
    var profileURL: String?
    
    init(id:String, name:String, cost:String,description: String,location: String,profileURL:String) {
        self.id = id
        self.name = name
        self.cost = cost
        self.location = location
        self.description = description
        self.profileURL = profileURL
    }
    
}
