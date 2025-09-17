# Blu-Bank

**Transfer List Application**  
BluBank Project – Base template for iOS 14+  

This project provides a clean folder structure and ready-to-use setup for modern UIKit projects.

---

## 📁 Project Structure

- **View**:  
  All UIKit views and SwiftUI-like helper views.

- **ViewModel**:  
  Handles logic and data management for each view.

- **Model**:  
  Data models.

- **NetworkRouter**:  
  Handles network requests; each router class manages its own domain.

- **Coordinator**:  
  Manages navigation and app flow.

- **DI (Dependency Injection)**:  
  Assembly classes for dependency injection using Swinject.

---

## 🌐 Network Layer

- `NetworkService` is implemented using `URLSession`.  
- Each request uses a Router for paths, parameters, and headers.  
- Router classes are separated by domain to keep the project organized.  

---

## 🛠 Dependency Injection

- Swinject is used for DI.  
- Assembly classes register and manage objects in the container.  

**Important Scopes**:  
- `.inObjectScope(.transient)` → A new instance is created every time it is resolved.  
- `.inObjectScope(.container)` → Singleton; resolved once and reused everywhere.  

---

## ✨ Features

- Base template for a professional project structure  
- UIKit extensions to simplify constraints (SwiftUI-like syntax)  
- Image management with **Kingfisher**  
- Package-based dependency management using **Swift Package Manager**  
- **SwiftLint** integrated for code style checks  

---

