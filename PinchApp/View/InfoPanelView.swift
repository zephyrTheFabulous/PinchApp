//
//  InfoPanelView.swift
//  PinchApp
//
//  Created by Anthony on 7/9/25.
//

import SwiftUI

struct InfoPanelView: View {
  var scale: CGFloat
  var offset: CGSize
  @State private var isInfoPanelVisible = false // hidden by default

  var body: some View {
    HStack {
      Image(systemName: "smallcircle.circle")
        .symbolRenderingMode(.hierarchical)
        .resizable()
//        .scaledToFit()
        .frame(width: 30, height: 30)
        .onLongPressGesture(minimumDuration: 1) {
          withAnimation(.easeOut) {
            isInfoPanelVisible.toggle() // long press shows info panel
          }
        }

      Spacer()
      HStack (spacing: 2) {
        Image(systemName: "arrow.up.left.and.arrow.down.right")
        Text("\(scale)")

        Spacer()

        Image(systemName: "arrow.left.and.right")
        Text("\(offset.width)")

        Spacer()

        Image(systemName: "arrow.up.and.down")
        Text("\(offset.height)")
      } //: HS
      .font(.footnote)
      .padding(8)
      .background(.ultraThinMaterial)
      .clipShape(.rect(cornerRadius: 8))
      .frame(maxWidth: 420)
      .opacity(isInfoPanelVisible ? 1:0)

      Spacer()
    } //: main HS
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  InfoPanelView(scale: 1, offset: .zero)
    .preferredColorScheme(.dark)
    .padding()
}
