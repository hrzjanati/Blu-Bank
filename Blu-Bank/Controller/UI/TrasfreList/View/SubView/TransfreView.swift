//
//  TransfreView.swift
//  Blu-Bank
//
//  Created by Nik on 16/09/2025.
//

import SwiftUI

// MARK: - ----------------- SwiftUI View
struct TransferView: View {
    
    // MARK: - ----------------- Properties
    @StateObject var vm: TransfreListViewController.ViewModel
    @EnvironmentObject var coordinator: TransfreListCoordinator
    @EnvironmentObject var favoritesManager: FavoritesManager<TransfreListModel>
     var networkService: NetworkServiceProtocol
    private var avatarImage : UIImageView?
    // MARK: - ----------------- Init
    init(vm: TransfreListViewController.ViewModel , networkService: NetworkServiceProtocol) {
        _vm = StateObject(wrappedValue: vm)
        self.networkService = networkService
    }
    
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
                ios15Refresh()
            } else {
                // iOS 14: use custom RefreshableList
                ios14Refresh()
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
    // MARK: - ----------------- iOS 15
    // iOS 15+ use native List + refreshable
    @available(iOS 15.0, *)
    private func ios15Refresh() -> some View {
        List {
            ForEach(vm.transferList, id: \.id) { item in
                TransferListCell(name: item.person.full_name,
                                 identifier: "\(item.more_info.total_transfer)",
                                 avatarURL:  item.person.avatar,
                                 networkService: self.networkService ,
                                 isFavorite: vm.isFavorite(item))
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
    }
    // MARK: - ----------------- iOS 14
    /// iOS 14: use custom RefreshableList
    private func ios14Refresh() -> some View {
        RefreshableList(items: $vm.transferList, isRefreshing: $vm.isRefreshing, onRefresh: {
            vm.refreshList()
        }) { item in
            TransferListCell(name: item.person.full_name,
                             identifier: "\(item.more_info.total_transfer)",
                             avatarURL:  item.person.avatar,
                             networkService: self.networkService ,
                             isFavorite: vm.isFavorite(item))
                .onTapGesture {
                    coordinator.showDetails(for: item)
                }
                .onAppear {
                    loadNextPageIfNeeded(for: item)
                }
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
                                coordinator.showDetails(for: item)
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
    let vm = TransfreListViewController.ViewModel(networkService: NetworkService(), favoritesManager: FavoritesManager<TransfreListModel>(key: ""))
    TransferView(vm: TransfreListViewController.ViewModel(networkService:NetworkService(),
                                                          favoritesManager: FavoritesManager<TransfreListModel>(key: "")), networkService: NetworkService())
    .environmentObject(vm)
}
