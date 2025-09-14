//
//  TransfreList.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import Foundation

struct TransfreListModel: Codable , Identifiable {
    struct Person: Codable {
        let full_name: String
        let email: String?
        let avatar: String
    }
    
    struct Card: Codable {
        let card_number: String
        let card_type: String
    }
    
    struct MoreInfo: Codable {
        let number_of_transfers: Int
        let total_transfer: Int
    }
    
    let person: Person
    let card: Card
    let last_transfer: String
    let note: String?
    let more_info: MoreInfo
    
    var id: String { card.card_number }
}
