import SwiftUI

struct InfosView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        
        VStack{
            
            VStack{
                
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                Text("Infos - Paciente")
                    .foregroundColor(.purple)
                    .font(.largeTitle)
            }
            
            
            List(viewModel.chars, id: \.self) { info in
                VStack(alignment: .leading) {
                   Text("Informações Pessoais")
                        .font(.headline)
                    Text("Nome: \(info.Nome)")
                    Text("Idade: \(info.Idade ?? "")")
                    if let tipoSanguineo = info.TipoSanguineo {
                        Text("Tipo Sanguíneo: \(info.TipoSanguineo!)")
                    }
                    
                    ForEach(info.AlergiaMedicamentos!, id: \.self){ med in
                        Text(med)
                    }
                    
                    Text("Contato de Emergência:")
                        .font(.headline)
                    Text("Nome: \(info.ContatoEmergenciaNome ?? "")")
                    Text("Telefone: \(info.ContatoEmergenciaTelefone ?? "")")
                }
            }
            .onAppear {
                viewModel.fetch()
            }
            
            
        }
    }
}

struct AContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
