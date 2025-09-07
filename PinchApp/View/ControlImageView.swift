//
//  ControlImageView.swift
//  PinchApp
//
//  Created by Anthony on 7/9/25.
//

import SwiftUI

struct ControlImageView: View {
  let icon: String

    var body: some View {
      Image(systemName: icon)
        .font(.system(size: 36))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
  ControlImageView(icon: "minus.magnifyingglass")
    .padding()
}
