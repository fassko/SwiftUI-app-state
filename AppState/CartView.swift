//
//  CartView.swift
//  AppState
//
//  Created by Kristaps Grinbergs on 11/03/2021.
//

import SwiftUI

struct CartView: View {
  @EnvironmentObject var order: Order
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    NavigationView {
      LazyVStack {
        ForEach(order.cart) { cartItem in
          HStack {
            Text(cartItem.item.name)
            Text(cartItem.count.description)
            
            Spacer()
            
            Button(action: {
              order.add(for: cartItem.item)
            }) {
              Image(systemName: "plus.circle.fill")
            }
            
            Button(action: {
              order.reduce(for: cartItem.item)
            }) {
              Image(systemName: "minus.circle.fill")
            }
          }
        }
        
        Spacer()
      }
      .padding()
      .navigationTitle("Cart")
      .navigationBarItems(trailing: Button("Clear") {
        order.clear()
      })
    }
  }
}

struct CartView_Previews: PreviewProvider {
  static var previews: some View {
    CartView()
  }
}
