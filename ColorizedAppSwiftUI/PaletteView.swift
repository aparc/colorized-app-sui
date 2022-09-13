//
//  PaletteView.swift
//  ColorizedAppSwiftUI
//
//  Created by Андрей Парчуков on 13.09.2022.
//

import SwiftUI

struct PaletteView: View {
    var color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(color)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white, lineWidth: 3)
            )
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView(color: .green)
    }
}
