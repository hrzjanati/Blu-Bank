//
//  UIView+Refreshable.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//
import SwiftUI
// MARK: - ----------------- Pull to Refresh
struct RefreshableList<Content: View>: UIViewRepresentable {
    @Binding var isRefreshing: Bool
    let onRefresh: () -> Void
    let content: Content
    
    init(isRefreshing: Binding<Bool>, onRefresh: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self._isRefreshing = isRefreshing
        self.onRefresh = onRefresh
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.refreshControl = context.coordinator.refreshControl
        tableView.delegate = context.coordinator
        tableView.dataSource = context.coordinator
        context.coordinator.parent = self
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
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
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
            1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            let hosting = UIHostingController(rootView: parent.content)
            hosting.view.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(hosting.view)
            NSLayoutConstraint.activate([
                hosting.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                hosting.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                hosting.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                hosting.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            ])
            return cell
        }
    }
}
