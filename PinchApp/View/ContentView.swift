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
  @State private var isDrawerOpen = false // slide drawer out

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

  var magnification: some Gesture {
    MagnificationGesture()
      .onChanged { value in
        withAnimation(.linear(duration: 1)) {
          if imageScale >= 1 && imageScale <= 5 {
            imageScale = value
          } else if imageScale > 5 {
            imageScale = 5
          }
        }
      }
      .onEnded { _ in
        if imageScale > 5 {
          imageScale = 5
        } else if imageScale <= 1 { // return back to 1
          resetImageState()
        }
      }
  }

  //MARK: - BODY
    var body: some View {
      NavigationStack {
        ZStack {
          Color.clear

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
          .gesture(dragGesture)
          .gesture(magnification)

          .animation(.linear(duration: 1), value: isAnimating)
        } // ZS
        .navigationTitle("Pinch & Zoom")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
          isAnimating = true
        }
        //MARK: - Info panel
        .overlay(alignment: .top) {
          InfoPanelView(scale: imageScale, offset: imageOffset)
            .padding(.horizontal, 16)
          .padding(.top, 30)
        }
        //MARK: - Control panel
        .overlay(alignment: .bottom) {
          Group {
            HStack {
              // Scale down
              Button {
                withAnimation(.spring()) {
                  if imageScale > 1 {
                    imageScale -= 1
                    if imageScale <= 1 { // return back to 1
                      resetImageState()
                    }
                  }
                }
              } label: {
                ControlImageView(icon: "minus.magnifyingglass")
              }

              // Reset
              Button {
                resetImageState()
              } label: {
                ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
              }

              // Scale up
              Button {
                withAnimation(.spring()) {
                  if imageScale < 5 {
                    imageScale += 1
                    if imageScale > 5 { // can't be more than 5
                      imageScale = 5
                    }
                  }
                }
              } label: {
                ControlImageView(icon: "plus.magnifyingglass")
              }
            } //: HS
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 12))
            .opacity(isAnimating ? 1:0)
          }
          .padding(.bottom, 30)
        }
        //MARK: - Drawer menu
        .overlay(alignment: .topTrailing) {
          HStack (spacing: 12) {
            // Handle
            Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
              .resizable()
              .scaledToFit()
              .frame(height: 40)
              .padding(8)
              .foregroundStyle(.secondary)
              .onTapGesture {
                withAnimation(.easeOut) {
                  isDrawerOpen.toggle()
                }
              }

            // Thumbnails
            Spacer()
          }
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 12))
        .opacity(isAnimating ? 1:0)
        .frame(width: 260)
        .padding(.top, UIScreen.main.bounds.height / 12) // distance from top of the screen no matter the size of it
        .offset(x: isDrawerOpen ? 20:215)
        }
      } //: NAV
    }
}

#Preview {
    ContentView()
}
