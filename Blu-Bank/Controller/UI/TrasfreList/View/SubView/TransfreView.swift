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
            if !vm.favoriteList.isEmpty {
                favoriteList()
            }
            HStack {
                Text("All")
                    .font(.title)
                Spacer()
            }
            .padding(.horizontal)
            // iOS 15+ use native List + refreshable
            if #available(iOS 15, *) {
                List {
                    ForEach(vm.transferList, id: \.id) { item in
                        TransferListCell(name: item.person.full_name,
                                         identifier: "\(item.more_info.total_transfer)")
                        .onTapGesture {
                            coordinator.showDetails(for: item)
                        }
                        .onAppear {
                            loadNextPageIfNeeded(for: item)
                        }
                    }
                    
                    if vm.isLoading && !vm.isRefreshing {
                        ProgressView("Loading more ...")
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
    // MARK: - ----------------- Load Next Page
    private func loadNextPageIfNeeded(for item: TransfreListModel) {
        guard let lastItem = vm.transferList.last else { return }
        if item.id == lastItem.id && vm.hasMore && !vm.isLoading {
            vm.fetchNextPage()
        }
    }
    // MARK: - ----------------- Favorite List View
    private func favoriteList() -> some View {
        VStack {
            HStack {
                Text("Favorites")
                    .font(.title)
                Spacer()
            }
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(vm.favoriteList, id: \.id) { item in
                        TransfreFavoriteCell(name: item.person.full_name, identifier: item.card.card_number)
                            .onTapGesture {
                                vm.toggleFavorite(item)
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 120)
        }
    }
}

// MARK: - ----------------- Preview
#Preview {
    let vm = TransfreListViewController.ViewModel(networkService: NetworkService())
    return TransferView()
        .environmentObject(vm)
}
