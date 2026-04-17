//
//  Lembrete.swift
//  MedSenior
//
//  Created by Student02 on 12/06/23.
//

import Foundation

struct lembrete: Identifiable {
    
    var id = UUID()
    var nome: String
    var dtInicio: Date
    var dtTermino: Date
    var intervalo: Int
    
    var proximoHorario: Date {
        
        let calendar = Calendar.current
        let horas = intervalo
        let proximaData = calendar.date(byAdding: .hour, value: horas, to: dtInicio)
        return proximaData ?? dtInicio
    }
    
}
