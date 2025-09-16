//
//  TransfreList.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit

class TransfreListViewController: BaseViewController {
    // MARK: - ----------------- Properties
    var coordinator: TransfreListCoordinator?
    var vm: ViewModel?
    // MARK: - ----------------- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let vm = vm else { return }
        vm.favoriteListUpdate()
    }
}
// MARK: - ----------------- Network call API
extension TransfreListViewController {
    ///SetUp View
    private func setUpView() {
        guard let vm = vm else { return }
        
        let swiftUIView = TransferView(vm: vm)
            .environmentObject(coordinator!)
        
        let hosting = UIHostingController(rootView: swiftUIView)
        
        guard let transfreView = hosting.view else { return }
        
        transfreView
            .add(base: self.view)
            .top(to: self.view.safeTopAnchor)
            .horizontal(to: self.view)
            .bottom(to: self.view.safeBottomAnchor)
            .closed()
        
    }
}
// MARK: - ----------------- Preview
/// You can use preview  if you want to see view on canvas
#if DEBUG
import SwiftUI

struct TransfreListViewController_preview: PreviewProvider {
    static var previews: some View {
        Group {
            // LightMode
            makePreview()
                .previewDisplayName("Light Mode")
                .environment(\.colorScheme, .light)
            
            // DarkMode
            makePreview()
                .previewDisplayName("Dark Mode")
                .environment(\.colorScheme, .dark)
        }
    }
    // Create VC with injected ViewModel
    static func makePreview() -> some View {
        let vc = TransfreListViewController()
        vc.vm = TransfreListViewController.ViewModel(networkService: NetworkService())
        return vc.showPreview()
    }
}
#endif
