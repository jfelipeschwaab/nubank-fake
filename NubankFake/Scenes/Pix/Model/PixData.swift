//
//  PixData.swift
//  NubankFake
//
//  Created by Jota Pe on 11/11/25.
//

import Foundation

struct PixData: Codable, Identifiable {
    let id: UUID
    let recipientName: String
    let cidade: String
    let recipientBank: String
    let recipientCPF: String
    
    init(id: UUID = UUID(), recipientName: String,cidade: String, recipientBank: String, recipientCPF: String){
        self.id = id
        self.recipientName = recipientName
        self.recipientBank = recipientBank
        self.recipientCPF = recipientCPF
    }
}
