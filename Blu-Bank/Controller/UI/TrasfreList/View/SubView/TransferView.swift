//
//  Transfre.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import SwiftUI

// MARK: - SwiftUI View
struct TransferView: View {
    @StateObject var vm = TransfreListViewController.ViewModel(networkService: NetworkService())
    
    var body: some View {
        RefreshableList(viewModel: vm, content: {
            List(vm.transferList, id: \.id) { item in
                Spacer()
                Text(item.person.full_name)
                Spacer()
                    .onAppear {
                        vm.fetchNextPageIfNeeded(currentItem: item)
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
    TransferView(vm: TransfreListViewController.ViewModel(networkService: NetworkService()))
}

