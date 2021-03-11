//
//  ContentView.swift
//  AppState
//
//  Created by Kristaps Grinbergs on 11/03/2021.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var order: Order
  
  var body: some View {
    NavigationView {
      GeometryReader { proxy in
        ZStack {
          List {
            NavigationLink("Apples", destination: ItemView(item: Item(name: "Apples")))
            NavigationLink("Oranges", destination: ItemView(item: Item(name: "Oranges")))
            NavigationLink("Mango", destination: ItemView(item: Item(name: "Mango")))
          }
          
          if !order.cart.isEmpty {
            VStack {
              Spacer()
              
              HStack {
                Spacer()
                
                Button(action: {
                  order.cartVisible = true
                }) {
                  VStack(alignment: .leading) {
                    ForEach(order.cart) { cartItem in
                      HStack {
                        Text(cartItem.item.name)
                        Text(cartItem.count.description)
                      }
                    }
                  }
                }
                
                Spacer()
              }
              .padding()
              .padding(.bottom, proxy.safeAreaInsets.bottom)
              .background(Color(.tertiarySystemBackground))
            }
            .edgesIgnoringSafeArea([.horizontal, .bottom])
          }
        }
      }
      .navigationTitle("Order Fruits")
      .sheet(isPresented: $order.cartVisible) {
        CartView()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(Order())
  }
}
