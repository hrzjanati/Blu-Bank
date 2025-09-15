//
//  UIView+Refreshable.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import SwiftUI
import UIKit
import Combine

// MARK: - ----------------- RefreshableList Wrapper
struct RefreshableList<Content: View, VM: ObservableObject>: UIViewControllerRepresentable {
    let viewModel: VM
    let content: () -> Content
    let onRefresh: () -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let hostingController = UIHostingController(rootView: content())
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.refresh(_:)), for: .valueChanged)

        DispatchQueue.main.async {
            if let scrollView = findScrollView(hostingController.view) {
                scrollView.refreshControl = refreshControl
            }
        }

        return hostingController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        (uiViewController as? UIHostingController<Content>)?.rootView = content()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel, onRefresh: onRefresh)
    }

    private func findScrollView(_ view: UIView) -> UIScrollView? {
        if let scrollView = view as? UIScrollView { return scrollView }
        for subview in view.subviews {
            if let found = findScrollView(subview) { return found }
        }
        return nil
    }

    class Coordinator: NSObject {
        let viewModel: VM
        let onRefresh: () -> Void
        private var cancellables = Set<AnyCancellable>()

        init(viewModel: VM, onRefresh: @escaping () -> Void) {
            self.viewModel = viewModel
            self.onRefresh = onRefresh
        }

        @objc func refresh(_ sender: UIRefreshControl) {
            onRefresh()

            if let vm = viewModel as? TransfreListViewController.ViewModel {
                vm.$isRefreshing
                    .removeDuplicates()
                    .receive(on: DispatchQueue.main)
                    .sink { isRefreshing in
                        if !isRefreshing {
                            sender.endRefreshing()
                        }
                    }
                    .store(in: &cancellables)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    sender.endRefreshing()
                }
            }
        }
    }
}
