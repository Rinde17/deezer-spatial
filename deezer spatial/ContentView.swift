//
//  ContentView.swift
//  deezer spatial
//
//  Created by Fabien Kattic on 11/01/2023.
//

import SwiftUI

struct SpatialView: View {
    var body: some View {
        ZStack {
            Image("wood")
                .resizable()
                .frame(width: 420, height: 600)
                .cornerRadius(300)
//            Ellipse()
//                .fill(.opacity(0))
//                .frame(width: 150, height: 300)
//                .border(Color.white, width: 40)
        }
        
        HStack {
            Image(systemName: "gobackward.10")
                .resizable()
                .frame(width: 48, height: 60)
                .padding(.top, 25)
            
            Image(systemName: "pause.fill")
                .resizable()
                .frame(width: 48, height: 60)
                .padding(.top, 25)
                .padding(.horizontal, 40)
        
            Image(systemName: "goforward.10")
                .resizable()
                .frame(width: 48, height: 60)
                .padding(.top, 25)
            
        }
        
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    SpatialView()
                } label: {
                    Label("Show détails view", systemImage: "globe")
                }
            }
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }
        /*
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, tout le monde!")
        }
        .padding()
         */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
