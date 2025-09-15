//
//  TransfreDetails.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import UIKit

class TransfreDetailsViewController: BaseViewController {
   // MARK: - ----------------- Properties
    var coordinator: TransfreDetailsCoordinator?
    var vm: ViewModel?
    // MARK: - ----------------- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(vm?.transferItem)
    }
}
// MARK: - ----------------- Network call API
extension TransfreDetailsViewController {
    private func fetchTransferList() {
    }
}
// MARK: - ----------------- Preview
/// You can use preview  if you want to see view on canvas
#if DEBUG
import SwiftUI

struct TransfreDetailsViewController_preview: PreviewProvider {
    static var previews: some View {
        Group {
            // LightMode
            makePreview()
                .previewDisplayName("Light Mode")
                .environment(\.colorScheme, .light)
            
            // DarkMode
            makePreview()
                .previewDisplayName("Dark Mode")
                .environment(\.colorScheme, .dark)
        }
    }

    // Create VC with injected ViewModel
    static func makePreview() -> some View {
        let mock = TransfreListModel(
            person: .init(full_name: "John Doe", email: "john@doe.com", avatar: ""),
            card: .init(card_number: "1234-5678-9012-3456", card_type: "MasterCard"),
            last_transfer: "2025-09-15",
            note: "Dinner payment",
            more_info: .init(number_of_transfers: 12, total_transfer: 5000)
        )
        
        let vc = TransfreDetailsViewController()
        vc.vm = TransfreDetailsViewController.ViewModel(mock)
        return vc.showPreview()
    }
}
#endif
