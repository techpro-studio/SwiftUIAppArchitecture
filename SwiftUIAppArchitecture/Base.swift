//
//  Base.swift
//  SwiftUIAppArchitecture
//
//  Created by Alex on 11/15/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import Swinject
import Combine


class BaseFactory {
    unowned let container: Container

    init(container: Container) {
        self.container = container
    }
}

class BagContainer {
    var cancellableBag: Set<AnyCancellable> = Set()

    deinit {
        cancellableBag.forEach({$0.cancel()})
    }
}
