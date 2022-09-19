//
//  CustomButton.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-16.
//

import SwiftUI

struct CustomButton: View {
    var color: Color
    var text: String
    var action: ()->Void
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(12)
                .padding()
        }
    }
}
