//
//  TransfreList.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import Foundation

struct TransfreListModel: Codable, Identifiable, Equatable {
    
    struct Person: Codable, Equatable {
        let full_name: String
        let email: String?
        let avatar: String
    }
    
    struct Card: Codable, Equatable {
        let card_number: String
        let card_type: String
    }
    
    struct MoreInfo: Codable, Equatable {
        let number_of_transfers: Int
        let total_transfer: Int
    }
    
    let person: Person
    let card: Card
    let last_transfer: String
    let note: String?
    let more_info: MoreInfo
    
    var id: String { card.card_number }
    
    private enum CodingKeys: String, CodingKey {
        case person, card, last_transfer, note, more_info
    }
}
