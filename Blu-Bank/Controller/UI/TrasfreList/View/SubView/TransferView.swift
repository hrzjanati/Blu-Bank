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
            if vm.transferList.isEmpty && vm.isLoading {
                ProgressView("Loading...")
            } else {
                List {
                    ForEach(vm.transferList.indices, id: \.self) { index in
                        let transfer = vm.transferList[index]
                        Spacer()
                        Text(transfer.card.card_number)
                        Spacer()
                            .onAppear {
                                if index == vm.transferList.count - 1 {
                                    vm.fetchTransferList()
                                }
                            }
                    }
                    if vm.isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }
            }
        }
        .onAppear {
            vm.fetchTransferList(reset: true)
        }
    }
}

// MARK: - ----------------- Preview
#Preview {
    TransferView(vm: TransfreListViewController.ViewModel(networkService: NetworkService()))
}
