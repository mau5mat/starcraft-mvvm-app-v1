//
//  MainCellViewModel.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

class MainCellViewModel {
    private(set) var type: BuildingType?
    private(set) var thumbnailImage: UIImage?
    
    init(buildingData: BuildingData) {
        self.type = buildingData.type
        self.thumbnailImage = buildingData.thumbnailImage
    }
    
    func typeToString() -> String {
        guard let type = self.type?.rawValue else { return "" }
        return type
    }
}
