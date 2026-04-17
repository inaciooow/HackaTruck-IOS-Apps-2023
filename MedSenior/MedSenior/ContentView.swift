//
//  ContentView.swift
//  MedSenior
//
//  Created by Student02 on 12/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var lembretesData = LembretesData()
    @ObservedObject var atendimentosData = AtendimentosData()
    @State private var showingHistorico = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack{ Text("MEDSENIOR")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                        .padding(.horizontal, 40)
                        .padding(.top, 20.0)
                    
                    Spacer()
                    NavigationLink(destination: InfosView() ){
                        Image(systemName: "info.circle")
                            .foregroundColor(Color.purple)
                            .padding(.horizontal, 27.0)
                            .padding(.top, 16)
                    }
                }
                
                List {
                    Section(header: Text("Lembretes")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.purple)) {
                            ForEach(lembretesData.ArrayLembretes.sorted {$0.dtInicio < $1.dtInicio }) { lembrete in
                                NavigationLink(destination: DetalhesLembreteView(detLembrete: lembrete)) {
                                    VStack (alignment: .leading) {
                                        Text(lembrete.nome)
                                            .font(.headline)
                                        Text(formatarDataHora(data: lembrete.proximoHorario))
                                            .font(.headline)
                                    }
                                }
                            }
                        }
                    
                    Section(header: Text("Atendimentos")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.purple)) {
                            ForEach(atendimentosData.ArrayAtendimentos.sorted{$0.data < $1.data}) { atendimento in
                                NavigationLink(destination:DetalhesAtendimentosView(detAtendimento: atendimento)){
                                    VStack (alignment: .leading){
                                        Text(atendimento.especialidade)
                                            .font(.headline)
                                        Text(formatarData(data:atendimento.data))
                                            .font(.headline)
                                        
                                    }
                                }
                            }
                        }
                }//.listStyle(InsetGroupedListStyle())
                
                HStack{
                    
                    Spacer()
                    
                    VStack{
                        
                        NavigationLink(destination: NovoLembreteView(lembretesData: lembretesData)) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color.purple)
                            Text("Novo Lembrete")
                                .foregroundColor(Color.purple)
                        }.padding(/*@START_MENU_TOKEN@*/.all, 1.0/*@END_MENU_TOKEN@*/).offset(x:-105)
                        
                        
                        NavigationLink(destination: NovoAtendimentoView(atendimentosData: atendimentosData)) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color.purple)
                            Text("Novo Atendimento")
                                .foregroundColor(Color.purple)
                        }.padding(/*@START_MENU_TOKEN@*/.all, 1.0/*@END_MENU_TOKEN@*/).offset(x:-105)
                        
                        Button(action: {
                            showingHistorico = true
                        }) {
                            Text("Ver histórico")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }.buttonStyle(.borderedProminent)
                            .tint(.purple)
                            .padding(1.0).offset(x:-105)
                            .padding(.bottom, 10)
                            .sheet(isPresented: $showingHistorico) {
                                HistoricoView()
                                    .environmentObject(lembretesData)
                                    .environmentObject(atendimentosData)
                            }
                    }
                    .font(.headline)
                    .foregroundColor(.purple)
                    .ignoresSafeArea()
                }
            }
            // .navigationBarTitle("Página Inicial")
            
        }
    }
    
    func formatarDataHora(data: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: data)
    }
    
    func formatarData(data: Date) ->String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: data)
    }
}

struct DetalhesLembreteView : View {
    var detLembrete: lembrete
    
    func formatarData(data: Date) ->String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: data)
    }
    
    var body: some View {
        
        VStack{
            
            Text("Lembrete")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.purple)
                .padding(.top, -350)
            
            
            VStack{
                
                Image("logo")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .padding(.top, -200)
                
                Text("Nome: " + detLembrete.nome)
                    .bold()
                    .padding(.top, 05)
                
                Text("Intervalo definido: " + String(detLembrete.intervalo) + " horas")
                    .bold()
                    .padding(.top, 05)
                
                Text("Data de Inicio: " + formatarData(data: detLembrete.dtInicio))
                    .bold()
                    .padding(.top, 05)
                
                Text("Data de Término: " + formatarData(data: detLembrete.dtTermino))
                    .bold()
                    .padding(.top, 05)
                
            }
        }
    }
}

struct DetalhesAtendimentosView : View {
    var detAtendimento: atendimento
    
    func formatarDataHora(data: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: data)
    }
    
    func formatarData(data: Date) ->String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: data)
    }
    
    var body: some View {
        
        ZStack{
            
            
            Text("Atendimento")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.purple)
                .padding(.top, -338.0)
            
            VStack {
               
                Image("logo")
                                .resizable()
                                .frame(width: 250, height: 250)
                                .padding(.vertical, 10.0)
                            
                Text("Hora: " + formatarDataHora(data: detAtendimento.data))
                    .bold()
                    .padding(.top, 05)
                
                Text("Data: " + formatarData(data: detAtendimento.data))
                    .bold()
                    .padding(.top, 05)
                
                Text("Especialidade: " + detAtendimento.especialidade)
                    .bold()
                    .padding(.top, 05)
                
                Text("Endereço: " + detAtendimento.endereco)
                    .bold()
                    .padding(.top, 05)
                
                
                Text("Nome do Profissional: " + detAtendimento.nomeMedico)
                    .bold()
                    .padding(.top, 05)
                
                Text("Cuidados Prévios: " + detAtendimento.cuidados)
                    .bold()
                    .padding(.top, 05)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
