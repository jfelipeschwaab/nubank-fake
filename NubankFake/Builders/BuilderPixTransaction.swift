//
//  BuilderPixTransaction.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 12/11/25.
//


//
//  BuilderPixTransaction.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 12/11/25.
//

import Foundation


final class BuilderPixTransaction {
    //MARK: Campos do destinatário (preenchidos por pixData)
    private var recipientName: String?
    private var cidade: String?
    private var recipientBank: String?
    private var recipientCPF: String?
    
    
    //MARK: Campos de transação
    private var pixKey: String?
    private var value: Double?
    
    
    init () {}
    
    
    @discardableResult
    func setRecipientName(_ name: String) -> BuilderPixTransaction {
        self.recipientName = name
        return self
    }
    
    
    @discardableResult
    func setCidade(_ cidade: String) -> BuilderPixTransaction {
        self.cidade = cidade
        return self
    }
    
    @discardableResult
    func setRecipientBank(_ bank: String) -> BuilderPixTransaction {
        self.recipientBank = bank
        return self
    }
    
    @discardableResult
    func setRecipientCpf(_ cpf: String) -> BuilderPixTransaction {
        self.recipientCPF = cpf
        return self
    }
    
    @discardableResult
    func setPixKey(_ pixKey: String) -> BuilderPixTransaction {
        self.pixKey = pixKey
        return self
    }
    
    @discardableResult
    func setValue(_ value: Double) -> BuilderPixTransaction {
        self.value = value
        return self
    }
    
    
    func build() throws -> PixTransactionResult {
        guard let name = recipientName,
              let cidade = cidade,
              let bank = recipientBank,
              let cpf = recipientCPF,
              let key = pixKey,
              let value = value else {
            throw BuilderError.missingData
        }
        
        let pixData = PixData(
            id: UUID(),
            recipientName: name,
            cidade: cidade,
            recipientBank: bank,
            recipientCPF: cpf
        )
        
        return PixTransactionResult(pixKey: key, pixData: pixData, value: value)
    }
    
    enum BuilderError: Error {
        case missingData
    }
}

struct PixTransactionResult {
    let pixKey: String
    let pixData: PixData
    let value: Double
}
