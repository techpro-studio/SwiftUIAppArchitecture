//
//  MainViewFactory.swift
//  SwiftUIAppArchitecture
//
//  Created by Alex on 11/15/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import SwiftUI

protocol MainViewFactory {
    func make() -> AnyView
}



class DefaultMainViewFactory : BaseFactory, MainViewFactory {
    func make() -> AnyView {
        let viewModel = MainViewModel(
            reachabillityManager: container.resolve(ReachabilityManager.self)!
        )
        return AnyView(MainView(viewModel: viewModel, detailViewFactory: container.resolve(DetailViewFactory.self)!))
    }
}
