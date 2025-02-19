//
//  CustomTextField.swift
//  TechSol
//
//  Created by fcp22 on 06/02/25.
//

import SwiftUI

struct CustomTextField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .padding(.leading, 10)

            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding(10)
            } else {
                TextField(placeholder, text: $text)
                    .padding(10)
            }
        }
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

