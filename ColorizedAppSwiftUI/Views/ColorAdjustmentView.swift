//
//  SliderView.swift
//  ColorizedAppSwiftUI
//
//  Created by Андрей Парчуков on 13.09.2022.
//

import SwiftUI

struct ColorAdjustmentView: View {
    
    @Binding var value: Double
    @Binding var focusOn: Color?
    let adjustedColor: Color
    
    @FocusState private var focused: Color?
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
                .onChange(of: value) {
                    textFieldValue = $0.formatted()
                }
            
            TextField("", text: $textFieldValue)
                .multilineTextAlignment(.trailing)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .focused($focused, equals: adjustedColor)
                .frame(width: 50)
                .alert(isPresented: $alertPresented) {
                    Alert(
                        title: Text("Wrong Format"),
                        message: Text("Please enter value from 0 to 255")
                    )
                }
        }
        .onChange(of: focused) { [focused] newValue in
            if newValue == adjustedColor {
                focusOn = newValue
            }
            let previousFocus = focused
            handleFocus(previousFocus)
        }
        .onChange(of: focusOn) {
            focused = $0
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
            self.focusOn = nil
        }
    }
    
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        ColorAdjustmentView(value: .constant(21), focusOn: .constant(.blue), adjustedColor: .green)
    }
}
