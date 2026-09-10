//
//  TextFieldLabelView.swift
//  Vollmed
//
//  Created by Patric Pereira on 09/09/26.
//

import SwiftUI

struct TextFieldLabelView: View {
    var label: String
    var placeholder: String
    var isSecure: Bool
    var keyboardType: UIKeyboardType = .default
    @Binding var value: String
    
    init(label: String, placeholder: String, value: Binding<String>, isSecure: Bool = false, keyboardType: UIKeyboardType = .default) {
        self.label = label
        self.placeholder = placeholder
        self._value = value
        self.isSecure = isSecure
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        Text(label)
            .font(.title3)
            .bold()
            .foregroundStyle(.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        Group {
            if isSecure {
                SecureField(placeholder, text: $value)
                    .padding(14.0)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            } else {
                TextField(placeholder, text: $value)
                    .padding(14.0)
                    .background(Color.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .keyboardType(keyboardType)
            }
        }
        
    }
}

#Preview {
    @Previewable @State var email = ""

    TextFieldLabelView(label: "Email", placeholder: "Insira seu email", value: $email)
}
