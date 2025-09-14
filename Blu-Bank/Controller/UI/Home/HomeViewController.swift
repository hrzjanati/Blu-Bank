//
//  ViewController.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import UIKit
import Combine

class HomeViewController: BaseViewController {
    var coordinator: HomeCoordinator?
    var vm: ViewModel?
    private var cancellAbles = Set<AnyCancellable>()
    // MARK: - ----------------- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTransferList()
    }
}
// MARK: - ----------------- Network call API
extension HomeViewController {
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
            .store(in: &cancellAbles)
    }
}
