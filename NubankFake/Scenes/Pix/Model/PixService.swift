//
//  File.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import Foundation

class PixService: PixServiceProtocol {
    
    private let MOCKED_VALID_KEY = "chavevalida@nubank.com"
    
    func validatePixKey(key: String) -> Bool {
        return key.lowercased() == MOCKED_VALID_KEY
    }
    
    private func returnPixInformation() -> PixData {
        return PixData(
            recipientName: "BetaEL",
            cidade: "Vanderley",
            recipientBank: "Nu pagamentos S.A.",
            recipientCPF: "***.673.***-40",
        )
    }
    
    func fetchPixDetails(forKey key: String) async -> Result<PixData, Error> {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        if validatePixKey(key: key) {
            let pixData = returnPixInformation()
            return .success(pixData)
        }else {
            return . failure(PixError.invalidKey)
        }
    }
    
   
}
