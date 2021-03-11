//
//  AppStateApp.swift
//  AppState
//
//  Created by Kristaps Grinbergs on 11/03/2021.
//

import SwiftUI

struct Item: Identifiable, Equatable {
  var id = UUID()
  
  let name: String
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.name == rhs.name
  }
}

struct CartItem: Identifiable {
  var id = UUID()
  
  var item: Item
  var count: Int
}

class Order: ObservableObject {
  @Published var cart: [CartItem] = [] {
    didSet {
      if cart.isEmpty {
        cartVisible = false
      }
    }
  }
  @Published var cartVisible = false
  
  func order(_ item: Item) {
    if let index = cart.firstIndex(where: { $0.item == item }) {
      var cartItem = cart[index]
      cartItem.count += 1
      cart[index] = cartItem
    } else {
      cart.append(CartItem(item: item, count: 1))
    }
  }
  
  func clear() {
    cart.removeAll()
  }
  
  func reduce(for item: Item) {
    guard let index = cart.firstIndex(where: { $0.item == item }) else {
      return
    }
    
    if cart[index].count == 1 {
      cart.remove(at: index)
    } else {
      cart[index].count -= 1
    }
  }
  
  func add(for item: Item) {
    guard let index = cart.firstIndex(where: { $0.item == item }) else {
      return
    }
    
    cart[index].count += 1
  }
}

@main
struct AppStateApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(Order())
    }
  }
}
