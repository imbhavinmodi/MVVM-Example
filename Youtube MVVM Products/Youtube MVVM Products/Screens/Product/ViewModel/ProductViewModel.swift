//
//  ProductViewModel.swift
//  Youtube MVVM Products
//
//  Created by Bhavin's on 07/06/23.
//

import Foundation

final class ProductViewModel {
    
    var products: [Product] = []
    
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    
    func fetchProduct() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProduct { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let product):
                self.products = product
                self.eventHandler?(.dataLoaded)
            case.failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
