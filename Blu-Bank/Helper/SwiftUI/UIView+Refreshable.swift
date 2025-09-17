//
//  UIView+Refreshable.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//
import SwiftUI
import Combine

// MARK: - RefreshableList for iOS 14+ (UIKit + SwiftUI)
struct RefreshableList<Item: Identifiable, Content: View>: UIViewRepresentable {
    @Binding var items: [Item]
    @Binding var isRefreshing: Bool
    let onRefresh: () -> Void
    let rowContent: (Item) -> Content
    
    init(items: Binding<[Item]>, isRefreshing: Binding<Bool>, onRefresh: @escaping () -> Void, @ViewBuilder rowContent: @escaping (Item) -> Content) {
        self._items = items
        self._isRefreshing = isRefreshing
        self.onRefresh = onRefresh
        self.rowContent = rowContent
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.delegate = context.coordinator
        tableView.dataSource = context.coordinator
        tableView.refreshControl = context.coordinator.refreshControl
        tableView.separatorStyle = .none
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        context.coordinator.parent = self
        uiView.reloadData()
        if isRefreshing {
            uiView.refreshControl?.beginRefreshing()
        } else {
            uiView.refreshControl?.endRefreshing()
        }
    }
    
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        var parent: RefreshableList
        let refreshControl = UIRefreshControl()
        
        init(parent: RefreshableList) {
            self.parent = parent
            super.init()
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        }
        
        @objc func refresh() {
            parent.onRefresh()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            parent.items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            let item = parent.items[indexPath.row]
            let hosting = UIHostingController(rootView: parent.rowContent(item))
            hosting.view.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(hosting.view)
            NSLayoutConstraint.activate([
                hosting.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                hosting.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                hosting.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                hosting.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            ])
            cell.selectionStyle = .none
            return cell
        }
    }
}
