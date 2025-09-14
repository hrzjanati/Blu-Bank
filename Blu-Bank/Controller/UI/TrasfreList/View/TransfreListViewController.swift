//
//  TransfreList.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit

class TransfreListViewController: UIViewController {
   // MARK: - ----------------- Properties
    var coordinator: TransfreListCoordinator?
    var vm: ViewModel?
    // MARK: - ----------------- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTransferList()
        view.backgroundColor = .systemGreen
    }
}
// MARK: - ----------------- Network call API
extension TransfreListViewController {
    private func fetchTransferList() {
        guard let vm = vm else {
            assertionFailure("ViewModel not injected")
            return
        }
        vm.fetchTransferList(1)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Completed fetching transfer list")
                case .failure(let error):
                    print("Error fetching transfer list: \(error)")
                }
            } receiveValue: { transfers in
                print("Received transfers:", transfers)
            }
            .store(in: vm.cancelBage)
    }
}
// MARK: - ----------------- Preview
/// You can use preview  if you want to see view on canvas
#if DEBUG
import SwiftUI

struct TransfreListViewController_preview: PreviewProvider {
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
        let vc = TransfreListViewController()
        vc.vm = TransfreListViewController.ViewModel(provider: TransfreListDIProviding())
        return vc.showPreview()
    }
}
#endif
