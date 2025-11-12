//
//  File.swift
//  NubankFake
//
//  Created by Letícia Delmilio Soares on 11/11/25.
//

import Foundation
import LocalAuthentication


protocol LocalAuthServiceProtocol {
    // Define o que o Serviço LOCAL deve fazer
    func authenticate(reason: String, completion: @escaping (Result<Void, LAError>) -> Void)
}

//protocolo pro serviço "da nunbank"
protocol AppAuthServiceProtocol {
    func validate(password: String) -> User?
}

