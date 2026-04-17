//
//  SwiftUIView.swift
//  MedSenior
//
//  Created by Student16 on 15/06/23.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
       
        Image("logo")
            .resizable()
            .aspectRatio(5 / 4 , contentMode: .fit)
            .edgesIgnoringSafeArea(.all)
            .saturation(0.9)
            .blur(radius: 2)
            .opacity(1.5)
        
        
        
        
        
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
