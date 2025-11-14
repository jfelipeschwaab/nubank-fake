//
//  File.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

import Foundation

class PixService: PixServiceProtocol {
    
    private let MOCKED_VALID_KEY = ["teste1@nubank.com", "teste2@nubank.com"]
    
    func fetchPixDetails(forKey key: String) async -> Result<PixData, Error> {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        if validatePixKey(key: key) {
            let pixData = returnPixInformation(key: key)
            return .success(pixData)
        }else {
            return . failure(PixError.invalidKey)
        }
    }
    
    private func validatePixKey(key: String) -> Bool {
        return MOCKED_VALID_KEY.contains(key.lowercased())
    }
    
    private func returnPixInformation(key: String) -> PixData {
        if key == "teste1@nubank.com" {
            return PixData(
                recipientName: "BetaEL",
                cidade: "Wanderley",
                recipientBank: "Nu pagamentos S.A.",
                recipientCPF: "***.673.***-40",
            )
        }else if key == "teste2@nubank.com" {
            return PixData(
            recipientName: "BetaH",
            cidade: "Betalândia",
            recipientBank: "Nu pagamentos S.A.",
            recipientCPF: "***.834.***-20"
            )
        }
        fatalError("Chave '\(key)' não encontrada")
    }
}
