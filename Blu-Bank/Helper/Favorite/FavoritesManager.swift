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
    
    // MARK: - ----------------- Save
    func save(_ items: [T]) {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Error saving favorites: \(error)")
        }
    }
    
    // MARK: - ----------------- Load
    func load() -> [T] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print("Error loading favorites: \(error)")
            return []
        }
    }
    
    // MARK: - ----------------- Toggel Append / Delete
    func toggle(_ item: T, in items: inout [T]) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        } else {
            items.append(item)
        }
        save(items)
    }
    
    // MARK: - ----------------- Check Already Exists
    func contains(_ item: T, in items: [T]) -> Bool {
        items.contains(where: { $0.id == item.id })
    }
}
