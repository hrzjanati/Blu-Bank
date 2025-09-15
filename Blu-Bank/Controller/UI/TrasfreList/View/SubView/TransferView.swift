//
//  Transfre.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import SwiftUI

// MARK: - SwiftUI View
import SwiftUI
import Combine

// MARK: - ----------------- SwiftUI View
struct TransferView: View {
    @StateObject var vm = TransfreListViewController.ViewModel(networkService: NetworkService())
    
    var body: some View {
        RefreshableList(viewModel: vm, content: {
            VStack {
                if vm.isRefreshing || (vm.isLoading && vm.transferList.isEmpty) {
                    ProgressView("Refreshing...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if vm.transferList.isEmpty {
                    Text("No transfers available")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(vm.transferList, id: \.id) { item in
                            VStack {
                                Spacer()
                                Text(item.person.full_name)
                                Spacer()
                            }
                            .onAppear {
                                vm.fetchNextPageIfNeeded(currentItem: item)
                            }
                        }
                        
                        if vm.isLoading && !vm.isRefreshing {
                            ProgressView("Loading more...")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }, onRefresh: {
            vm.refreshList()
        })
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
