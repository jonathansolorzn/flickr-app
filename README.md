# Flickr App

App following Service-oriented Architecture and MVVM Pattern.

## Table of Contents
- [🚀 Environment setup](#-environment-setup)
  - [🌍 Project Specifications](#-project-specifications)
  - [🧱 Dependencies](#-dependencies)
- [🤔 About the project](#-about-the-project)
  - [🗂 Folder Structure](#-folder-structure)
  - [📦 Dependency Injection](#-dependency-injection)
  - [🔌 App Communication](#-app-communication)
  
## 🚀 Environment setup

### 🌍 Project Specifications
1. Xcode 13+
2. iOS 11+
3. Swift 5
5. MVVM

### 🧱 Dependencies
1. [Swinject](https://github.com/Swinject/Swinject) a Dependency Injection framework
2. SwinjectAutoregistration extension to Swinject
3. [Moya](https://github.com/Moya/Moya) a Network abstraction layer framework
4. [Kingfisher](https://github.com/onevcat/Kingfisher) a pure-Swift library for downloading and caching images from the web
5. [SkeletonUI](https://github.com/CSolanaM/SkeletonUI) a skeleton loading animation

## 🤔 About the project

### 🗂 Folder Structure

```swift
Aspyre
|-- Services
|   -- Models
|-- SupportingFiles
|-- Networking
|-- App
|   -- Utilities
|   -- Extensions
|-- Dependencies // Dependencies Registrations into a DI Container
|-- Views // App Screens with SwiftUI
|   -- Models
|   -- Components
|   -- Detail
|   -- Gallery 
```

### 📦 Dependency Injection

For Service Registration the project uses Swinject `Library/Dependencies/Injector.swift`

```swift
enum Injector {
    static let sharedAssambler: Assembler = {
        let container = Container()
        let assambler = Assembler(
            [
                ServiceAssembly()
            ],
            container: container
        )
        return assambler
    }()
}
```
* `ServiceAssembly` Services registrations

### 🔌 App Communication

```mermaid
  graph TD;
      A(Networking) --> B(Services);
      B(Services) --> C(ViewModel);
      C(ViewModel) --> D(View);
```
