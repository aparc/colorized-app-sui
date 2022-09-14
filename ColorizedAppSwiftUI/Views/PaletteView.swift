//
//  PaletteView.swift
//  ColorizedAppSwiftUI
//
//  Created by Андрей Парчуков on 13.09.2022.
//

import SwiftUI

struct PaletteView: View {
    let red: Double
    let green: Double
    let blue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color(red: red, green: green, blue: blue))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white, lineWidth: 3)
            )
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView(red: 255, green: 255, blue: 255)
    }
}
