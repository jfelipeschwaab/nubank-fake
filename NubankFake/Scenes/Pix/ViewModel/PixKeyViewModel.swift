//
//  File.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import Foundation
import Combine

class PixKeyViewModel {
    
    private let pixService: PixServiceProtocol
    
    var onKeyValidated: ((PixData) -> Void)?
    
    @Published var key: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(pixService: PixServiceProtocol) {
        self.pixService = pixService
    }
    
    ///Ação chamada pelo botão Avançar da View
    @MainActor
    func validateKey() {
        isLoading = true
        errorMessage = nil
        
        Task {
            let result = await pixService.fetchPixDetails(forKey: key)
            isLoading = false
            
            switch result {
            case .success(let pixData):
                onKeyValidated?(pixData)
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}
