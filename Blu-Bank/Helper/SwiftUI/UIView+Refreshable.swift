//
//  UIView+Refreshable.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import SwiftUI
import UIKit
import Combine

// MARK: - ----------------- Refreshable SwiftUI Wrapper
struct RefreshableList<Content: View, VM: ObservableObject>: UIViewControllerRepresentable {
    @ObservedObject var viewModel: VM
    let content: () -> Content
    let onRefresh: () -> Void
    
    func makeUIViewController(context: Context) -> UIViewController {
        let hostingController = UIHostingController(rootView: content())
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.refresh(_:)), for: .valueChanged)
        
        // پیدا کردن UIScrollView داخل view hierarchy
        DispatchQueue.main.async {
            func findScrollView(_ view: UIView) -> UIScrollView? {
                if let scrollView = view as? UIScrollView { return scrollView }
                for subview in view.subviews {
                    if let found = findScrollView(subview) { return found }
                }
                return nil
            }
            
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
        Coordinator(onRefresh: onRefresh)
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject {
        let onRefresh: () -> Void
        
        init(onRefresh: @escaping () -> Void) {
            self.onRefresh = onRefresh
        }
        
        @objc func refresh(_ sender: UIRefreshControl) {
            onRefresh()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                sender.endRefreshing()
            }
        }
    }
}
