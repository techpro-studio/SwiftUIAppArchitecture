//
//  Dependencies.swift
//  SwiftUIAppArchitecture
//
//  Created by Alex on 11/15/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import Swinject



func BuildDependencies(container: Container) -> Container {
    container.register(ReachabilityManager.self) { _ -> ReachabilityManager in
        DefaultReachabilityManager()
    }

    container.register(MainViewFactory.self) { resolver -> MainViewFactory in
        DefaultMainViewFactory(
            reachabilityManager: container.resolve(ReachabilityManager.self)!,
            detailViewFactory: container.resolve(DetailViewFactory.self)!
        )
    }

    container.register(DetailViewFactory.self) { resolver -> DetailViewFactory in
        DefaultDetailViewFactory()
    }

    return container
}
