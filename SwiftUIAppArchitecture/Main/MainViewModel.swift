//
//  MainViewModel.swift
//  SwiftUIAppArchitecture
//
//  Created by Alex on 11/15/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation



class MainViewModel : BagContainer, ObservableObject {

    private let reachabillityManager:  ReachabilityManager

    init(reachabillityManager: ReachabilityManager) {
        self.reachabillityManager = reachabillityManager
        super.init()
        self.computePublishers()
    }

    @Published  var input: String = ""
    @Published  var isButtonEnabled = false


    func computePublishers() {

        self.reachabillityManager.reachable.combineLatest($input).map { (reachable, input) -> Bool in
            if !reachable{
                return false
            }
            return input.count >= 5
        }.receive(on: RunLoop.main)
        .assign(to: \MainViewModel.isButtonEnabled, on: self)
        .store(in: &cancellableBag)

    }


}
