//
//  ItemView.swift
//  AppState
//
//  Created by Kristaps Grinbergs on 11/03/2021.
//

import SwiftUI

struct ItemView: View {
  @EnvironmentObject var order: Order
  
  var item: Item
  
  var body: some View {
    VStack {
      Button(action: {
        order.order(item)
      }) {
        Label("Order", systemImage: "cart")
      }
    }
    .navigationTitle(item.name)
  }
}

struct ItemView_Previews: PreviewProvider {
  static var previews: some View {
    ItemView(item: .mocked)
  }
}

extension Item {
  static var mocked: Item {
    Item(name: "Mocked")
  }
}
