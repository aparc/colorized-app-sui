//
//  ContentView.swift
//  ColorizedAppSwiftUI
//
//  Created by Андрей Парчуков on 13.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState private var focusedColorField: Color?
    
    @State private var red = Double.random(in: 0...255).rounded()
    @State private var green = Double.random(in: 0...255).rounded()
    @State private var blue = Double.random(in: 0...255).rounded()
    
    var body: some View {
        ZStack {
            Color.indigo.ignoresSafeArea()
            VStack(spacing: 20) {
                PaletteView(
                    color: Color(red: red/255, green: green/255, blue: blue/255)
                )
                .frame(height: 200)
                
                ColorAdjustmentView(value: $red, focus: _focusedColorField, adjustedColor: .red)
                ColorAdjustmentView(value: $green, focus: _focusedColorField, adjustedColor: .green)
                ColorAdjustmentView(value: $blue, focus: _focusedColorField, adjustedColor: .blue)
                
                Spacer()
            }
            .padding()
            .toolbar {
                keyboardToolbar
            }
        }
    }
    
    private var keyboardToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .keyboard) {
            Button(action: focusUp) {
                Image(systemName: "chevron.up")
            }
            Button(action: focusDown) {
                Image(systemName: "chevron.down")
            }
            Spacer()
            Button("Done") {
                focusedColorField = nil
            }
        }
    }
    
    private func focusUp() {
        guard let focusedColorField = focusedColorField else { return }
        self.focusedColorField = nextFocusedColor(after: focusedColorField, downWard: false)
    }
    
    private func focusDown() {
        guard let focusedColorField = focusedColorField else { return }
        self.focusedColorField = nextFocusedColor(after: focusedColorField)
    }
    
    private func nextFocusedColor(after color: Color, downWard: Bool = true) -> Color {
        switch color {
        case .red:
            return downWard ? .green : .blue
        case .green:
            return downWard ? .blue : .red
        case .blue:
            return downWard ? .red : .green
        default:
            return .red
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
