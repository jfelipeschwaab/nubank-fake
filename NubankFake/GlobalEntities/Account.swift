//
//  Account.swift
//  NubankFake
//
//  Created by João Felipe Schwaab on 11/11/25.
//

struct Account {
    let id: Int
    let userName: String
    var accountBalance: Double
}

struct MockData {
    static var joaoAccount = Account(
        id: 1,
        userName: "João",
        accountBalance: 1234.56
    )
}
