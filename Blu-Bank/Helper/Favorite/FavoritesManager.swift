//
//  FavoritesManager.swift
//  Blu-Bank
//
//  Created by Nik on 16/09/2025.
//

import Foundation
import Combine

final class FavoritesManager<T: Identifiable & Codable>: ObservableObject {
    
    // MARK: - ----------------- Properties
    @Published private(set) var items: [T] = []
    private let key: String
    
    // MARK: - ----------------- Init
    init(key: String) {
        self.key = key
        self.items = loadItems()
    }
    
    // MARK: - ----------------- Load Items
    private func loadItems() -> [T] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print("Error loading favorites: \(error)")
            return []
        }
    }
    
    // MARK: - ----------------- Save Items
    private func saveItems() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Error saving favorites: \(error)")
        }
    }
    
    // MARK: - ----------------- Check Favorite
    func isFavorite(_ item: T) -> Bool {
        return items.contains(where: { $0.id == item.id })
    }
    
    // MARK: - ----------------- Toggle Favorite
    func toggle(_ item: T) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        } else {
            items.append(item)
        }
        saveItems()
    }
    
    // MARK: - ----------------- Get All Favorites
    func all() -> [T] {
        return items
    }
}
