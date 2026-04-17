//
//  HistoricoView.swift
//  MedSenior
//
//  Created by Student02 on 13/06/23.
//

import SwiftUI

struct HistoricoView: View {
    @EnvironmentObject var lembretesData: LembretesData
    @EnvironmentObject var atendimentosData: AtendimentosData
    
    @State private var filtroPrimario: FiltroPrimario = .atendimentos
    @State private var filtroSecundario: FiltroSecundario = .ultimaSemana
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Filtros")) {
                    Picker("Filtro Primário:", selection: $filtroPrimario) {
                        Text("Atendimentos").tag(FiltroPrimario.atendimentos)
                        Text("Lembretes").tag(FiltroPrimario.lembretes)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Filtro Secundário:", selection: $filtroSecundario) {
                        Text("Última Semana").tag(FiltroSecundario.ultimaSemana)
                        Text("Últimos 15 Dias").tag(FiltroSecundario.ultimos15Dias)
                        Text("Último Mês").tag(FiltroSecundario.ultimoMes)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Histórico")) {
                    ForEach(filtrarHistorico()) { item in
                        VStack(alignment: .leading) {
                            Text(item.tipo)
                            Text("Data: \(formatarDataHora(item.data))")
                        }
                    }
                }
            }
        }
        .navigationTitle("Histórico")
    }
    
    private func filtrarHistorico() -> [HistoricoItem] {
        var historicoFiltrado: [HistoricoItem] = []
        
        switch filtroPrimario {
        case .atendimentos:
            let atendimentos = atendimentosData.ArrayAtendimentos
            historicoFiltrado = criarHistorico(atendimentos: atendimentos)
        case .lembretes:
            let lembretes = lembretesData.ArrayLembretes
            historicoFiltrado = criarHistorico(lembretes: lembretes)
        default: break
        }
        
        return filtrarPorPeriodo(historicoFiltrado)
    }
    
    private func criarHistorico(atendimentos: [atendimento]) -> [HistoricoItem] {
        return atendimentos.map { HistoricoItem(tipo: "Atendimento", data: $0.data) }
    }
    
    private func criarHistorico(lembretes: [lembrete]) -> [HistoricoItem] {
        return lembretes.map { HistoricoItem(tipo: "Lembrete", data: $0.dtInicio) }
    }
    
    private func filtrarPorPeriodo(_ historico: [HistoricoItem]) -> [HistoricoItem] {
        let hoje = Date()
        var historicoFiltrado: [HistoricoItem] = []
        
        switch filtroSecundario {
        case .ultimaSemana:
            let dataInicial = Calendar.current.date(byAdding: .day, value: -6, to: hoje) ?? hoje
            historicoFiltrado = historico.filter { $0.data >= dataInicial && $0.data <= hoje }
        case .ultimos15Dias:
            let dataInicial = Calendar.current.date(byAdding: .day, value: -14, to: hoje) ?? hoje
            historicoFiltrado = historico.filter { $0.data >= dataInicial && $0.data <= hoje }
        case .ultimoMes:
            let dataInicial = Calendar.current.date(byAdding: .month, value: -1, to: hoje) ?? hoje
            historicoFiltrado = historico.filter { $0.data >= dataInicial && $0.data <= hoje }
        default: break
        }
        
        return historicoFiltrado
    }
    
    private func formatarDataHora(_ data: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: data)
    }
}

struct HistoricoItem: Identifiable {
    let id = UUID()
    let tipo: String
    let data: Date
}

struct FiltroPrimario: Hashable {
    let id = UUID()
    let descricao: String
    
    static let atendimentos = FiltroPrimario(descricao: "Atendimentos")
    static let lembretes = FiltroPrimario(descricao: "Lembretes")
}

struct FiltroSecundario: Hashable {
    let id = UUID()
    let descricao: String
    
    static let ultimaSemana = FiltroSecundario(descricao: "Última Semana")
    static let ultimos15Dias = FiltroSecundario(descricao: "Últimos 15 Dias")
    static let ultimoMes = FiltroSecundario(descricao: "Último Mês")
}

struct HistoricoView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricoView()
    }
}
