//
//  ContentView.swift
//  Aula06MapsJorgeTarde
//
//  Created by Student16 on 23/05/23.
//

import SwiftUI
import MapKit

struct City : Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let flag: String
    let description: String
}

let cityInfo = [
    City(name: "Belo Horizonte",
         coordinate: CLLocationCoordinate2D(latitude: -19.919064, longitude: -43.938538),
         flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/1920px-Flag_of_Brazil.svg.png",
         description: "Belo Horizonte é a capital do estado de Minas Gerais, no sudeste do Brasil. Rodeada de montanhas, a cidade é conhecida pelo enorme Estádio Mineirão. Construído em 1965, o estádio alberga também o Museu Brasileiro do Futebol. Nas proximidades encontra-se a Lagoa da Pampulha e o Conjunto Arquitetónico da Pampulha, que inclui a Igreja de São Francisco de Assis, cujo teto é ondulado e que foi concebida pelo arquiteto modernista brasileiro Oscar Niemeyer."),
    City(name: "Salvador",
         coordinate: CLLocationCoordinate2D(latitude: -12.973024, longitude: -38.502507),
         flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/1920px-Flag_of_Brazil.svg.png",
         description: "Salvador, a capital do estado da Bahia no nordeste do Brasil, é conhecida pela arquitetura colonial portuguesa, pela cultura afrobrasileira e pelo litoral tropical. O bairro do Pelourinho é seu coração histórico, com vielas de paralelepípedo terminando em praças grandes, prédios coloridos e igrejas barrocas, como São Francisco, com trabalhos em madeira revestidos com ouro."),
    City(name: "São Paulo",
         coordinate: CLLocationCoordinate2D(latitude: -23.554911, longitude: -46.640241),
         flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/1920px-Flag_of_Brazil.svg.png",
         description: "São Paulo, centro financeiro do Brasil, está entre as cidades mais populosas do mundo, com diversas instituições culturais e uma rica tradição arquitetônica. Há prédios simbólicos como a catedral neogótica, o Edifício Martinelli, um arranha-céu inaugurado em 1929, e o Edifício Copan, com suas linhas curvas projetadas pelo arquiteto modernista Oscar Niemeyer. A igreja em estilo colonial do Pátio do Colégio marca o local onde os padres jesuítas fundaram a cidade em 1554.")
]



struct ContentView: View {
    
    @State private var showingSheet = false
    
    @State private var soumapa = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -14.2450, longitude: -51.9253), span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40))
    
    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(Color.white)
                .frame(height: 1)
            Text("World Map")
                .font(.title)
                .fontWeight(.bold)
            Text("Brazil")
            
            Map(coordinateRegion: $soumapa, annotationItems: cityInfo) { location in
                MapAnnotation(coordinate: location.coordinate){
                    Button("O"){
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        VStack{
                            Text(location.name)
                                .font(.title)
                            AsyncImage(url: URL(string: location.flag)){
                                image in image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 100, height: 150)
                            
                            Text(location.description)
                                .padding()
                        }
                    }
                }
            }
            
            Rectangle()
                .foregroundColor(Color.white)
                .frame(height: 10)
            
            //  ScrollView(.horizontal){
            HStack{
                ForEach(cityInfo) { info in
                    Button(info.name){
                        soumapa = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: info.coordinate.latitude, longitude: info.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            //  }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
