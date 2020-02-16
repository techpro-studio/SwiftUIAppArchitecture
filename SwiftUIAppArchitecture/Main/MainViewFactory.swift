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



struct DefaultMainViewFactory : MainViewFactory {

    let reachabilityManager: ReachabilityManager
    let detailViewFactory: DetailViewFactory

    func make() -> AnyView {
        let viewModel = MainViewModel(reachabillityManager: reachabilityManager)
        return AnyView(MainView(viewModel: viewModel, detailViewFactory: detailViewFactory))
    }
}
