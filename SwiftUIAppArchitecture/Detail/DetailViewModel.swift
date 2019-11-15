//
//  DetailViewModel.swift
//  SwiftUIAppArchitecture
//
//  Created by Alex on 11/15/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation


class DetailViewModel: BagContainer, ObservableObject {

    @Published var value: String = ""

    func setValue(value: String) {
        self.value = value
    }
}
