//
//  ProtocolPixService.swift
//  NubankFake
//
//  Created by Jota Pe on 11/11/25.
//

import Foundation

protocol PixServiceProtocol {
    func fetchPixDetails(forKey key: String) async -> Result<PixData, Error>
}
