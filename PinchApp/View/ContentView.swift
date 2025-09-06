//
//  ContentView.swift
//  PinchApp
//
//  Created by Anthony on 6/9/25.
//

import SwiftUI

struct ContentView: View {
  @State private var isAnimating = false

    var body: some View {
      NavigationStack {
        ZStack {
          Image("magazine-front-cover")
            .resizable()
            .scaledToFit()
          .clipShape(.rect(cornerRadius: 10))
          .padding()
          .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
          .opacity(isAnimating ? 1:0)
          .animation(.linear(duration: 1), value: isAnimating)
        } // ZS
        .navigationTitle("Pinch & Zoom")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
          isAnimating = true
        }
      } //: NAV
    }
}

#Preview {
    ContentView()
}
