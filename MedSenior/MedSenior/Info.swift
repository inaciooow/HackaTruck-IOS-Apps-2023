//
//  Info.swift
//  MedSenior
//
//  Created by Student16 on 15/06/23.
//

import Foundation

struct InFo: Decodable, Hashable{
    
    let Nome: String
    let Idade: String?
    let TipoSanguineo: String?
    let AlergiaMedicamentos: [String]?
    let ContatoEmergenciaNome: String?
    let ContatoEmergenciaTelefone: String?
    
}

class ViewModel: ObservableObject{
    
    @Published var chars : [InFo] = []
    
    func fetch(){
        
        guard let url = URL(string: "http://192.168.128.253:1880/infos")
                
        else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([InFo].self, from: data)
                
                DispatchQueue.main.async {
                    self?.chars = parsed
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
