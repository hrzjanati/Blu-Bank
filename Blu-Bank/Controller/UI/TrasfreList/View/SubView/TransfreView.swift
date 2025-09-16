//
//  TransfreView.swift
//  Blu-Bank
//
//  Created by Nik on 16/09/2025.
//

import SwiftUI

// MARK: - ----------------- SwiftUI View
struct TransferView: View {
    @StateObject var vm = TransfreListViewController.ViewModel(networkService: NetworkService())
    @EnvironmentObject var coordinator: TransfreListCoordinator
    
    var body: some View {
        List {
                ForEach(vm.transferList, id: \.id) { item in
                    VStack {
                        TransferListCell(name: item.person.full_name,
                                         identifier: item.card.card_number)
                    }
                    .onTapGesture {
                        coordinator.showDetails(for: item)
                    }
                    .onAppear {
                        if let index = vm.transferList.firstIndex(where: { $0.id == item.id }) {
                            let thresholdIndex = vm.transferList.index(vm.transferList.endIndex, offsetBy: -3)
                            if index >= thresholdIndex {
                                vm.fetchNextPageIfNeeded(currentItem: item)
                            }
                        }
                    }
                }
                if vm.isLoading && !vm.isRefreshing {
                    ProgressView("Loading more...")
                        .frame(maxWidth: .infinity)
                }
        }
        .onAppear {
            if vm.transferList.isEmpty {
                vm.fetchNextPageIfNeeded(currentItem: nil)
            }
        }
    }
}
// MARK: - ----------------- Preview
#Preview {
    let vm = TransfreListViewController.ViewModel(networkService: NetworkService())
    return TransferView()
        .environmentObject(vm)
}
