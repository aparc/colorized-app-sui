//
//  SliderView.swift
//  ColorizedAppSwiftUI
//
//  Created by Андрей Парчуков on 13.09.2022.
//

import SwiftUI

struct ColorAdjustmentView: View {
    
    @Binding var value: Double
    @FocusState var focus: Color?
    let adjustedColor: Color
    
    @State private var textFieldValue = ""
    @State private var alertPresented = false
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .lineLimit(1)
                .foregroundColor(.white)
                .frame(width: 35, alignment: .leading)
            
            Slider(value: $value, in: 0...255, step: 1)
                .tint(adjustedColor)
                .onChange(of: value) { newValue in
                    textFieldValue = newValue.formatted()
                }
            
            TextField("", text: $textFieldValue)
                .multilineTextAlignment(.trailing)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .focused($focus, equals: adjustedColor)
                .frame(width: 50)
                .alert(isPresented: $alertPresented) {
                    Alert(
                        title: Text("Wrong Format"),
                        message: Text("Please enter value from 0 to 255")
                    )
                }
        }
        .onChange(of: focus) { [focus] _ in
            let previousFocus = focus
            handleFocus(previousFocus)
        }
        .onAppear {
            textFieldValue = value.formatted()
        }
    }
    
    private func handleFocus(_ focus: Color?) {
        guard let focus = focus else { return }
        guard focus == adjustedColor else { return }
        
        if let value = Double(textFieldValue), (0...255).contains(value) {
            withAnimation {
                self.value = value
            }
        } else {
            value = 0
            alertPresented.toggle()
            self.focus = nil
        }
    }
    
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        ColorAdjustmentView(value: .constant(21), adjustedColor: .green)
    }
}
