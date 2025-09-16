//
//  FavoritesManager.swift
//  Blu-Bank
//
//  Created by Nik on 16/09/2025.
//

import Foundation
final class FavoritesManager<T: Identifiable & Codable> {
    private let key: String
    
    init(key: String) {
        self.key = key
    }
    
    // MARK: - Load from UserDefaults
    private func loadItems() -> [T] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print("Error loading favorites: \(error)")
            return []
        }
    }
    
    // MARK: - Save to UserDefaults
    private func saveItems(_ items: [T]) {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Error saving favorites: \(error)")
        }
    }
    
    // MARK: - Check if Favorite
    func isFavorite(_ item: T) -> Bool {
        let items = loadItems()
        return items.contains(where: { $0.id == item.id })
    }
    
    // MARK: - Toggle Favorite
    func toggle(_ item: T) {
        var items = loadItems()
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        } else {
            items.append(item)
        }
        saveItems(items)
    }
    
    // MARK: - Get All Favorites
    func all() -> [T] {
        return loadItems()
    }
}
