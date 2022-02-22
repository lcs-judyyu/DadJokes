//
//  ContentView.swift
//  DadJokes
//
//  Created by Judy Yu on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Text("How do you organize a space party? You planet.")
                .multilineTextAlignment(.leading)
                .font(.title2)
                .padding(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 4)
                )
                .padding(10)
            
            Button(action: {
                
            }, label: {
                Image(systemName: "heart.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.black)
            })
            
            Button(action: {
           
            }, label: {
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                Text("Favourites")
                Spacer()
            }
            
            List {
                Text("Which side of the chicken has more feathers? The outside.")
                Text("Why did the Clydesdale give the pony a glass of water? Because he was a little horse!")
                Text("The great thing about stationery shops is they're always in the same place...")
            }
            
            Spacer()
                        
        }
        .navigationTitle("icanhazdadjoke?")
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
