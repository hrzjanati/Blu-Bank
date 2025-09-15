//
//  TransfreDetails.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import UIKit
import Foundation
import Combine

extension TransfreDetailsViewController {
    class ViewModel : BaseViewModel {
        // MARK: - ----------------- Propertires
        var transferItem : TransfreListModel
        // MARK: - ----------------- Init
         init(_ transferItem: TransfreListModel) {
             self.transferItem = transferItem
             super.init()
        }
    }
}
