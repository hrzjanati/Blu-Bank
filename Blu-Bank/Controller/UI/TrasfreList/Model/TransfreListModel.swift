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
    
    var id = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case person, card, last_transfer, note, more_info
    }
}


// MARK: - ----------------- Mock Data
extension TransfreListModel {
    static let mock: [TransfreListModel] = [
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "حسین رضازاده جنتی",
                email: "hossein@example.com",
                avatar: "https://i.pravatar.cc/150?img=1"
            ),
            card: TransfreListModel.Card(
                card_number: "6037991234567890",
                card_type: "بانک ملی"
            ),
            last_transfer: "2025-09-14T11:25:00Z",
            note: "اولین تراکنش",
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 5,
                total_transfer: 125000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        ),
        TransfreListModel(
            person: TransfreListModel.Person(
                full_name: "زهرا محمدی",
                email: nil,
                avatar: "https://i.pravatar.cc/150?img=2"
            ),
            card: TransfreListModel.Card(
                card_number: "5892109876543210",
                card_type: "بانک صادرات"
            ),
            last_transfer: "2025-09-13T15:40:00Z",
            note: nil,
            more_info: TransfreListModel.MoreInfo(
                number_of_transfers: 2,
                total_transfer: 78000
            )
        )
    ]
}
