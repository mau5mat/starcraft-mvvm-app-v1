//
//  MainCellViewModel.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

class MainCellViewModel {
    private(set) var title: String?
    private(set) var thumbnailImage: UIImage?
    
    init(buildingData: BuildingData) {
        self.title = buildingData.title
        self.thumbnailImage = buildingData.thumbnailImage
    }
}
