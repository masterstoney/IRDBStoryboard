//
//  IRDBDataModel.swift
//  IRDBStoryboard
//
//  Created by Tendaishe Gwini on 20/03/2019.
//  Copyright © 2019 Tendaishe Gwini. All rights reserved.
//

import UIKit

class IRDBDataModel: Codable {
    
    var franchise: [IRDBFranchise] = []
    
}

class IRDBFranchise: Codable {
    
    var franchiseName = String()
    var entries: [IRDBEntry] = []
    
}

class IRDBEntry: Codable {
    
    var name: String?
    var format: String?
    var yearStart: String?
    var yearEnd: String?
    var episodes: Int?
    var network: String?
    var imageURL: String?
    var description: String?
    var summary: String?
    var starring: [IRDBActor] = []
    
}

class IRDBActor: Codable {
    
    var name = String()
    var playing = String()
    
}
