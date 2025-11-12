//
//  Account.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

struct Account {
    let id: String
    let userName: String
    let balance: Double
}

struct MockData {
    static let joaoAccount = Account(
        id: "1",
        userName: "João",
        balance: 1234.56
    )
}
