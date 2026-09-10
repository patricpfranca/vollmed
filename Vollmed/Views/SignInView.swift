//
//  SignInView.swift
//  Vollmed
//
//  Created by Patric Pereira on 08/09/26.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
            
            Text("Olá")
                .font(.title2)
                .bold()
                .foregroundStyle(.accent)
            
            Text("Preencha para acessar sua conta.")
                .font(.title3)
                .foregroundStyle(.gray)
                .padding(.bottom)
            
            TextFieldLabelView(label: "Email", placeholder: "Insira seu email", value: $email, keyboardType: .emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            TextFieldLabelView(label: "Senha", placeholder: "Insira sua senha", value: $password, isSecure: true)
            
            Button(action: {
                //
            }, label: {
                ButtonView(text: "Entrar")
            })
            
            NavigationLink {
                SignUpView()
            } label: {
                Text("Ainda não possui uma conta? Cadastre-se")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            }

        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignInView()
}
