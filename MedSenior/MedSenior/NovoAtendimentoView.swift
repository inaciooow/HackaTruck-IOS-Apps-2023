//
//  NovoAtendimentoView.swift
//  MedSenior
//
//  Created by Student02 on 12/06/23.
//

import SwiftUI

struct NovoAtendimentoView: View {
    
    @StateObject var atendimentosData = AtendimentosData()
    @State private var novoAtendimento : atendimento = atendimento(especialidade: "", nomeMedico: "", data: Date(), endereco: "", cuidados: "")
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Form {
                    Section(header: Text("Novo Atendimento")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hue: 0.734, saturation: 1.0, brightness: 1.0))
                        .multilineTextAlignment(.center)
                        .padding(.vertical))
                    {
                        TextField("Especialidade", text: $novoAtendimento.especialidade)
                            .padding(.vertical, 10.0)
                        
                        TextField("Nome do médico", text: $novoAtendimento.nomeMedico)
                            .padding(.vertical, 10.0)
                        
                        DatePicker("Data e Horário", selection: $novoAtendimento.data, displayedComponents: [.date, .hourAndMinute])
                            .padding(.vertical, 5.0)
                        
                        TextField("Endereço ", text: $novoAtendimento.endereco)
                            .padding(.vertical, 10.0)
                        
                        TextField("Cuidados ", text: $novoAtendimento.cuidados)
                            .padding(.vertical, 10.0)
                    }
                    
                    Button(action : {
                        atendimentosData.adicionarAtendimento(novoAtendimento: novoAtendimento)
                        presentationMode.wrappedValue.dismiss();
                        let content = UNMutableNotificationContent()
                        content.title = "Consulta com \(novoAtendimento.especialidade) as \(novoAtendimento.data)"
                        content.subtitle = "Cuidados previos: \(novoAtendimento.cuidados)"
                        content.sound = UNNotificationSound.default

                        // show this notification five seconds from now
                        let dateN = (novoAtendimento.data).addingTimeInterval(TimeInterval(-86400))
                        let dateComponents = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: dateN)
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                    }) {
                        Text("Salvar")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(10.0)
                            .foregroundColor(Color(hue: 0.734, saturation: 1.0, brightness: 1.0)
                            )
                            .cornerRadius(10)
                        
                    }.frame(maxWidth: .infinity, alignment: .center)
                    
                }
            }
        }
        
    }
}

class AtendimentosData : ObservableObject{
    
    @Published var ArrayAtendimentos : [atendimento] = []
    
    func adicionarAtendimento(novoAtendimento : atendimento) {
        ArrayAtendimentos.append(novoAtendimento)
    }
}

struct NovoAtendimentoView_Previews: PreviewProvider {
    static var previews: some View {
        NovoAtendimentoView()
    }
}
