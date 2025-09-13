//
//  BaseViewController.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - ----------------- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
