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
        VStack {
            // iOS 15+ use native List + refreshable
            if #available(iOS 15, *) {
                List {
                    ForEach(vm.transferList, id: \.id) { item in
                        TransferListCell(name: item.person.full_name, identifier: item.card.card_number)
                            .onTapGesture {
                                coordinator.showDetails(for: item)
                            }
                            .onAppear {
                                loadNextPageIfNeeded(for: item)
                            }
                    }
                    
                    if vm.isLoading && !vm.isRefreshing {
                        ProgressView("Loading more...")
                            .frame(maxWidth: .infinity)
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    vm.refreshList()
                }
            } else {
                // iOS 14: use custom RefreshableList
                RefreshableList(items: $vm.transferList, isRefreshing: $vm.isRefreshing, onRefresh: {
                    vm.refreshList()
                }) { item in
                    TransferListCell(name: item.person.full_name, identifier: item.card.card_number)
                        .onTapGesture {
                            coordinator.showDetails(for: item)
                        }
                        .onAppear {
                            loadNextPageIfNeeded(for: item)
                        }
                }
            }
        }
        .onAppear {
            if vm.transferList.isEmpty {
                vm.loadFirstPage()
            }
        }
    }
    
    private func loadNextPageIfNeeded(for item: TransfreListModel) {
        guard let lastItem = vm.transferList.last else { return }
        if item.id == lastItem.id && vm.hasMore && !vm.isLoading {
            vm.fetchNextPage()
        }
    }
}

// MARK: - ----------------- Preview
#Preview {
    let vm = TransfreListViewController.ViewModel(networkService: NetworkService())
    return TransferView()
        .environmentObject(vm)
}
