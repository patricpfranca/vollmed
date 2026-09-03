//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Patric Pereira on 03/09/26.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    @State private var selectedDate: Date = Date()
    
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
                .onAppear {
                    UIDatePicker.appearance().minuteInterval = 15
                }
            
            Button(action: {
                print("Botão pressionado")
            }, label: {
                ButtonView(text: "Agendar consulta")
            })
        }
        .padding()
        .navigationTitle("Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    ScheduleAppointmentView()
}
