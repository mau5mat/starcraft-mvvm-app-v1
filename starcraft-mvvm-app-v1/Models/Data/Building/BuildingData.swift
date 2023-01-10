//
//  BuildingData.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

struct BuildingData {
    private(set) var title: String?
    private(set) var thumbnailImage: UIImage?
    
    init(title: String, thumbnailImage: UIImage) {
        self.title = title
        self.thumbnailImage = thumbnailImage
    }
}
