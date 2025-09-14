//
//  Transfre.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import SwiftUI

// MARK: - SwiftUI View
struct TransferView: View {
    @ObservedObject var vm: TransfreListViewController.ViewModel
    
    var body: some View {
        VStack {
            if vm.transferList.isEmpty {
                ProgressView("Loading...")
            } else {
                List(vm.transferList, id: \.id) { transfer in
                    Text(transfer.card.card_number)
                }
            }
        }
        .onAppear {
            fetchTransferList()
        }
    }
    /// Fetch Transfer List
    private func fetchTransferList() {
        vm.fetchTransferList(1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { transfers in
                vm.transferList = transfers
            })
            .store(in: &vm.cancellables)
    }
}

// MARK: - ----------------- Preview
#Preview {
    TransferView(vm: TransfreListViewController.ViewModel(provider: TransfreListDIProviding()))
}
