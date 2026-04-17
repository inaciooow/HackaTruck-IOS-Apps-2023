//
//  Atendimento.swift
//  MedSenior
//
//  Created by Student02 on 12/06/23.
//

import Foundation

struct atendimento: Identifiable {
    
    var id = UUID()
    var especialidade: String
    var nomeMedico: String
    var data: Date
    var endereco: String
    var cuidados: String
}
