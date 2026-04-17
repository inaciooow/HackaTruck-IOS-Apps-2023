//
//  NovoLembreteView.swift
//  MedSenior
//
//  Created by Student02 on 12/06/23.
//

import SwiftUI

struct NovoLembreteView: View {
    
    @StateObject var lembretesData = LembretesData()
    @State private var novoLembrete: lembrete = lembrete(nome: "", dtInicio: Date(), dtTermino: Date(), intervalo: 0)
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.cyan, .white],
                               startPoint: .top,
                               endPoint: .center)
                .ignoresSafeArea()
                
                VStack {
                    Form {
                        Section(header: Text("Novo Lembrete")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hue: 0.734, saturation: 1.0, brightness: 1.0))
                            .multilineTextAlignment(.center)
                            .padding(.vertical))
                        {
                            TextField("Nome *", text: $novoLembrete.nome)
                                .padding(.vertical, 10.0)
                            
                            DatePicker("Data de Início *", selection: $novoLembrete.dtInicio, displayedComponents: .date)
                                .padding(.vertical, 5.0)
                            
                            DatePicker("Data de Término", selection: $novoLembrete.dtTermino, displayedComponents: .date)
                                .padding(.vertical, 5.0)
                            Stepper("Intervalo * : \(novoLembrete.intervalo) horas", value: $novoLembrete.intervalo, in: 0...24)
                                .padding(.vertical, 5.0)
                        }
                        
                        Button(action : {
                            lembretesData.adicionarLembrete(novoLembrete: novoLembrete)
                            presentationMode.wrappedValue.dismiss();
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("All set!")
                                } else if let error = error {
                                    print(error.localizedDescription)
                                }
                            };
                            let content = UNMutableNotificationContent()
                            content.title = "Tome o remédio \(novoLembrete.nome)"
                            //content.subtitle = "It looks hungry"
                            content.sound = UNNotificationSound.default

                            // show this notification five seconds from now
                            let dateComponents = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: novoLembrete.dtInicio)
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
            }//zstack
        }//navigationstack
    }
}

class LembretesData: ObservableObject {
    @Published var ArrayLembretes: [lembrete] = []
    
    func adicionarLembrete(novoLembrete : lembrete) {
        ArrayLembretes.append(novoLembrete)
    }
}
struct NovoLembreteView_Previews: PreviewProvider {
    static var previews: some View {
        NovoLembreteView()
    }
}
