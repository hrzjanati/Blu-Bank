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
    private var hstackFavoriteBtn = UIStackView()
    private var favoriteBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        return btn
    }()
    private var spacerView: UIView = {
        let view = UIView()
        view.setBackground(color: .clear)
            .closed()
        return view
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
// MARK: - ----------------- Setup View
extension TransfreDetailsViewController {
    private func setupView(_ avatraImageUrl : String?, _ name : String  , _ email : String , _ cardNumber : String , _ bankName : String) {
        mainStackView
            .add(base: self.view)
            .top(to: self.view.safeTopAnchor, constant: 32)
            .horizontal(to: self.view , constant: 16)
            .closed()
        
        mainStackView
            .stack(axis: .vertical, alignment: .fill, distribution: .fill , space: 12)
            .addArrange(views: hstackFavoriteBtn ,
                        avatarImageView ,
                        nameLbl ,
                        emailLbl ,
                        cardNumberLbl ,
                        bankNameLbl)
            .closed()
        /// Avatar Image
        avatarImageView
            .right(to: mainStackView.rightAnchor)
            .height(constant: 96)
            .closed()
        
        avatarImageView.setImage(from: avatraImageUrl)
        /// Favorite Button
        hstackFavoriteBtn
            .right(to: mainStackView.rightAnchor)
            .closed()
        
        hstackFavoriteBtn
            .stack(axis: .horizontal, alignment: .fill, distribution: .fill)
            .addArrange(views: spacerView ,favoriteBtn)
            .closed()
        
        favoriteBtn
            .top(to: hstackFavoriteBtn.topAnchor)
            .ratio(constant: 40)
            .closed()
        spacerView
            .top(to: hstackFavoriteBtn.topAnchor)
            .closed()
        
        /// Name
        nameLbl
            .right(to: mainStackView.rightAnchor)
            .closed()
        nameLbl.setTitle(string: name).closed()
        /// Email
        emailLbl
            .right(to: mainStackView.rightAnchor)
            .closed()
        
        emailLbl.setTitle(string: email).closed()
        /// Card Number
        cardNumberLbl
            .right(to: mainStackView.rightAnchor)
            .closed()
        
        cardNumberLbl.setTitle(string: cardNumber).closed()
        /// Bank Name
        bankNameLbl
            .right(to: mainStackView.rightAnchor)
            .closed()
        bankNameLbl.setTitle(string: bankName).closed()
        
        favoriteBtn.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        guard let vm = vm else { return }
        favoriteBtn.setImage(UIImage(systemName: vm.isFavorite() ? "star.fill" : "star"), for: .normal)
    }
    // MARK: - ----------------- Update Button
    @objc private func didTapFavorite() {
        guard let vm = vm else { return }
        vm.toggleFavorite()
        favoriteBtn.setImage(UIImage(systemName: vm.isFavorite() ? "star.fill" : "star"), for: .normal)
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
        vc.vm = TransfreDetailsViewController.ViewModel(mock, favoritesManager: FavoritesManager<TransfreListModel>(key: ""))
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
