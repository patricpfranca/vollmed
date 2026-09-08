//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Patric Pereira on 08/09/26.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    var appointmentID: String
    let service = WebService()
    
    @State private var reasonToCancel = ""
    @State private var isCancelAppointment: Bool = false
    @State private var showAlert: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    func cancelAppointment() async {
        do {
            if try await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel) {
                print("Consulta cancelada com sucesso!")
                isCancelAppointment = true
            } else {
                isCancelAppointment = false
            }
        } catch {
            print("Ocorreu um erro ao desmarcar a consulta \(error)")
            isCancelAppointment = false
        }
        showAlert = true
    }
    
    var body: some View {
        VStack(spacing: 16.0) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .cornerRadius(16.0)
                .frame(maxHeight: 300)
            
            Button(action: {
                Task {
                    await cancelAppointment()
                }
            }, label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
            })
        }
        .padding()
        .navigationTitle("Cancelar consulta")
        .navigationBarTitleDisplayMode(.large)
        .alert(isCancelAppointment ? "Sucesso!" : "Ops, algo deu errado!",
               isPresented: $showAlert,
               presenting: isCancelAppointment) { _ in
            Button(action: {
                dismiss()
            }, label: {
                Text("OK")
            })
        } message: { isScheduled in
            if isScheduled {
                Text("A consulta foi cancelada com sucesso!")
            } else {
                Text("Houve um erro ao cancelar sua consulta. Por favor tente novamente ou entre em contato via telefone.")
            }
        }
    }
}

#Preview {
    CancelAppointmentView(appointmentID: "123")
}
