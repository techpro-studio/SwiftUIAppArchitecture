//
//  DetailView.swift
//  SwiftUIAppArchitecture
//
//  Created by Alex on 11/15/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import SwiftUI
import Swinject

struct DetailView: View {

    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        Text(viewModel.value).navigationBarTitle("Detail")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        // bad hack
        BuildDependencies(container: Container()).resolve(DetailViewFactory.self)!.make(value: "Hello")
    }
}
