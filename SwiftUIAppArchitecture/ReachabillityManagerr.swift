//
//  ReachabillityManagerr.swift
//  SwiftUIAppArchitecture
//
//  Created by Alex on 11/15/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import Network
import Combine



protocol ReachabilityManager {
    var reachable: CurrentValueSubject<Bool, Never> { get }
}


class DefaultReachabilityManager: ReachabilityManager {
    let reachable: CurrentValueSubject<Bool, Never> = CurrentValueSubject(true)

    private let monitor = NWPathMonitor()

    init() {
        observeNetwork()
    }

    func observeNetwork () {
        self.monitor.start(queue: .main)
        self.monitor.pathUpdateHandler = {[weak self] path in
            self?.reachable.send(path.status == .satisfied)
        }
    }

    deinit {
        self.monitor.cancel()
    }

}
