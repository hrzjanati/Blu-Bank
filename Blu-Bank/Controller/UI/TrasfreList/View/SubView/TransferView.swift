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
        VStack {
                RefreshableList(isRefreshing: $vm.isRefreshing, onRefresh: {
                    vm.refreshList()
                }) {
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
