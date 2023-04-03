//
//  PlaceImageView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI

struct PlaceImageView: View {
    
    @StateObject var vm: ImageViewModel
    
    init(imageName: String) {
        _vm = StateObject(wrappedValue: ImageViewModel(imageName: imageName))
    }
    
    var body: some View {
        if let image = vm.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                 
        } else {
            Image("placeItemDefault")
                .resizable()
                .scaledToFill()
        }
    }
}
