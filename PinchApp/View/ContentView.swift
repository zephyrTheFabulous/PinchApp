//
//  ContentView.swift
//  PinchApp
//
//  Created by Anthony on 6/9/25.
//

import SwiftUI

struct ContentView: View {
  @State private var isAnimating = false
  @State private var imageScale: CGFloat = 1
  @State private var imageOffset: CGSize = .zero

  func resetImageState() {
    withAnimation(.spring()) {
      imageScale = 1
      imageOffset = .zero
    }
  }

  var dragGesture: some Gesture {
    DragGesture()
      .onChanged { value in
        withAnimation(.linear(duration: 1)) {
          imageOffset = value.translation
        }
      }
      .onEnded { _ in // no need for .translation
        if imageScale <= 1 {
          resetImageState()
        }
      }
  }

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
          .offset(x: imageOffset.width, y: imageOffset.height)
          .scaleEffect(imageScale)
          //MARK: - Double tap gesture
          .onTapGesture(count: 2) {
            if imageScale == 1 {
              withAnimation(.spring()) {
                imageScale = 5
              }
            } else {
              resetImageState()
            }
          }
          //MARK: - Drag gesture
          .gesture(dragGesture)
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
