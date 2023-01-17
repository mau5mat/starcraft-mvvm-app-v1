//
//  BuildingData.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

enum BuildingType: String {
    case barracks = "Barracks"
    case factory = "Factory"
    case starport = "Starport"
}

struct BuildingData {
    private(set) var type: BuildingType?
    private(set) var thumbnailImage: UIImage?
    
    init(type: BuildingType, thumbnailImage: UIImage) {
        self.type = type
        self.thumbnailImage = thumbnailImage
    }
}
