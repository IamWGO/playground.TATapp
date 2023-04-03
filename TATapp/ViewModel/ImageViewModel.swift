//
//  ImageViewModel.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI
import Combine

class ImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let imageName: String
    private let dataService: ImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(imageName: String) {
        self.imageName = imageName
        self.dataService = ImageService(imageName: imageName)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
        
    }
     
}
