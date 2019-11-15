//
//  DetailViewFactory.swift
//  SwiftUIAppArchitecture
//
//  Created by Alex on 11/15/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import SwiftUI


protocol DetailViewFactory {
    func make(value: String) -> AnyView
}



class DefaultDetailViewFactory : BaseFactory, DetailViewFactory {
    func make(value: String) -> AnyView {
        let viewModel = DetailViewModel()
        viewModel.setValue(value: value)
        return AnyView(DetailView(viewModel: viewModel))
    }
}
