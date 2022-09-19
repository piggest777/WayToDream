//
//  MytextFieldStyle.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-16.
//

import SwiftUI


struct CustomTextField: View {
    var placeHolder: String
    @Binding var value: String
    
    var lineColor: Color
    var width: CGFloat
    
    var body: some View {
        VStack {
            TextField(self.placeHolder, text: $value)
            .padding()
            .font(.title)
            
            Rectangle().frame(height: self.width)
                .padding(.horizontal, 20).foregroundColor(self.lineColor)
        }
    }
}
