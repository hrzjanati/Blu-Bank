//
//  TransfreDetails.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import UIKit

class TransfreDetailsViewController: BaseViewController {
    // MARK: - ----------------- Properties
    var coordinator: TransfreDetailsCoordinator?
    var vm: ViewModel?
    
    private var mainStackView = UIStackView()
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private var nameLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = .systemFont(ofSize: 17, weight: .medium)
        lbl.textAlignment = .center
        return lbl
    }()
    private var emailLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = .systemFont(ofSize: 17, weight: .medium)
        lbl.textAlignment = .center
        return lbl
    }()
    private var cardNumberLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = .systemFont(ofSize: 17, weight: .medium)
        lbl.textAlignment = .center
        return lbl
    }()
    private var bankNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = .systemFont(ofSize: 17, weight: .medium)
        lbl.textAlignment = .center
        return lbl
    }()
    // MARK: - ----------------- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubscribtion()
    }
}
// MARK: - ----------------- Subscribtion
extension TransfreDetailsViewController {
    private func setupSubscribtion() {
        guard let vm = vm else { return }
        vm.$transferItem.sink { [weak self] item in
            self?.setupView( item.person.avatar
                             ,item.person.full_name,
                             item.person.email ?? "",
                             item.card.card_number,
                             item.card.card_type)
        }
        .store(in: &vm.cancellables)
    }
}
// MARK: - ----------------- Network call API
extension TransfreDetailsViewController {
    private func setupView(_ avatraImageUrl : String?, _ name : String  , _ email : String , _ cardNumber : String , _ bankName : String) {
        mainStackView
            .add(base: self.view)
            .top(to: self.view.safeTopAnchor, constant: 32)
            .horizontal(to: self.view , constant: 16)
            .closed()
        
        mainStackView
            .stack(axis: .vertical, alignment: .fill, distribution: .fill , space: 16)
            .addArrange(views: avatarImageView ,
                        nameLbl ,
                        emailLbl ,
                        cardNumberLbl ,
                        bankNameLbl)
            .closed()
        
        avatarImageView
            .right(to: mainStackView.rightAnchor)
            .height(constant: 96)
            .closed()
        
        avatarImageView.setImage(from: avatraImageUrl)
        
        nameLbl
            .right(to: mainStackView.rightAnchor)
            .height(constant: 48)
            .closed()
        nameLbl.setTitle(string: name).closed()
        
        emailLbl
            .right(to: mainStackView.rightAnchor)
            .height(constant: 48)
            .closed()
        
        emailLbl.setTitle(string: email).closed()
        
        cardNumberLbl
            .right(to: mainStackView.rightAnchor)
            .height(constant: 48)
            .closed()
        
        cardNumberLbl.setTitle(string: cardNumber).closed()
        
        bankNameLbl
            .right(to: mainStackView.rightAnchor)
            .height(constant: 48)
            .closed()
        bankNameLbl.setTitle(string: bankName).closed()
    }
}
// MARK: - ----------------- Preview
/// You can use preview  if you want to see view on canvas
#if DEBUG
import SwiftUI

struct TransfreDetailsViewController_preview: PreviewProvider {
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
        let mock = TransfreListModel(
            person: .init(full_name: "John Doe", email: "john@doe.com", avatar: ""),
            card: .init(card_number: "1234-5678-9012-3456", card_type: "MasterCard"),
            last_transfer: "2025-09-15",
            note: "Dinner payment",
            more_info: .init(number_of_transfers: 12, total_transfer: 5000)
        )
        
        let vc = TransfreDetailsViewController()
        vc.vm = TransfreDetailsViewController.ViewModel(mock)
        return vc.showPreview()
    }
}
#endif


extension UIImageView {
    func setImage(from urlString: String?, placeholder: UIImage? = UIImage(systemName: "person.circle")) {
        self.image = placeholder
        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
