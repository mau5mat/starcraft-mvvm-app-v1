//
//  DialogueViewModel.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import Foundation

class DialogueViewModel {
    private(set) var type: DialogueType = .error
    private(set) var title: String = ""
    private(set) var message: String = ""

    init(data: DialogueData) {
        self.type = data.type
        self.title = data.title
        self.message = data.message
    }
}
