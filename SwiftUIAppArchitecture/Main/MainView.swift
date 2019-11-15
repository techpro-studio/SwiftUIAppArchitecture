//
//  MainView.swift
//  SwiftUIAppArchitecture
//
//  Created by Alex on 11/15/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import SwiftUI
import Swinject

struct MainView: View {

    @ObservedObject var viewModel: MainViewModel
    let detailViewFactory: DetailViewFactory

    @State private var isActiveDetail = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Input", text: $viewModel.input).frame(height: 50.0)
                NavigationLink(destination: detailViewFactory.make(value: viewModel.input), isActive: $isActiveDetail, label: {Text("GO!")}).disabled(!viewModel.isButtonEnabled)
            }.frame(width: 200.0).navigationBarTitle("Main")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        // bad hack 
        BuildDependencies(container: Container()).resolve(MainViewFactory.self)!.make()
    }
}
