//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Patric Pereira on 03/09/26.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    let service = WebService()
    var specialistID: String
    
    @State private var selectedDate: Date = Date()
    @State private var showAlert: Bool = false
    @State private var isAppointmentScheduled: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    func scheduleAppointment() async {
        do {
            if let _ = try await service.scheduleAppointment(specialistID: specialistID, patientID: patientID, date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao agendar consulta \(error)")
        }
        showAlert = true
    }
    
    var body: some View {
        VStack {
            Text("Selecione a data e o hórario da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da consulta", selection: $selectedDate, in: Date()...)
                .datePickerStyle(.graphical)
                .environment(\.locale, Locale.init(identifier: "pt-BR"))
            
            Button(action: {
                Task {
                    await scheduleAppointment()
                }
            }, label: {
                ButtonView(text: "Agendar consulta")
            })
        }
        .padding()
        .navigationTitle("Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isAppointmentScheduled ? "Sucesso!" : "Erro!",
               isPresented: $showAlert,
               presenting: isAppointmentScheduled) { _ in
            Button(action: {
                dismiss()
            }, label: {
                Text("OK")
            })
        } message: { isScheduled in
            if isScheduled {
                Text("A consulta foi agendada com sucesso!")
            } else {
                Text("Houve um erro ao agendar sua consulta, por favor tente novamente ou entre em contato via telefone.")
            }
        }

    }
}

#Preview {
    ScheduleAppointmentView(specialistID: "1")
}
