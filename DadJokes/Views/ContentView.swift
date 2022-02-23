//
//  ContentView.swift
//  DadJokes
//
//  Created by Judy Yu on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Stored Properties
    @State var currentJoke: DadJoke = DadJoke(id: "",
                                              joke: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                              status: 0)
    
    //list of favourite joke
    @State var favourites: [DadJoke] = [] //empty list
    
    //ckeck if currentjoke is already a favourite
    @State var currentJokeAddedToFavourites: Bool = false
    
    //MARK: Computed Properties
    var body: some View {
        VStack(spacing: 20) {
            
            Text(currentJoke.joke)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.leading)
                .font(.title2)
                .padding(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 4)
                )
                .padding(10)
            

                Image(systemName: "heart.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(currentJokeAddedToFavourites == true ? .red : .secondary) //muted color for the mode
                    .onTapGesture {
                        //only add to the list if it is not in there
                        if currentJokeAddedToFavourites == false {
                            favourites.append(currentJoke)
                            //record that this joke is added
                            currentJokeAddedToFavourites = true
                        }
                    }
            
            Button(action: {
                //task type along asynchronous code within the button and update user interface when data is ready
                //other tasks keep running
                Task {
                    //call the function
                    await loadNewJoke()
                }
            }, label: {
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                Text("Favourites")
                Spacer()
            }
            
            //iterate over the list of favourites
            //each individual favourite is accessible via "currentFavourite"
            List(favourites, id: \.self) { currentFavourite in
                Text(currentFavourite.joke)
            }
            
            Spacer()
            
        }
        // When the app opens, get a new joke from the web service
        .task {
            //calling/ invoking function, "call site" of the function
            //results may take time to complete, code bellow will keep running
            await loadNewJoke()
        }
        .navigationTitle("icanhazdadjoke?")
        .padding()
    }
    
    //MARK: Functions
    //define function
    //"async": can run alongside other tasks
    func loadNewJoke() async {
        // Assemble the URL that points to the endpoint
        let url = URL(string: "https://icanhazdadjoke.com/")!
        
        // Define the type of data we want from the endpoint
        // Configure the request to the web site
        var request = URLRequest(url: url)
        // Ask for JSON data
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        
        // Start a session to interact (talk with) the endpoint
        let urlSession = URLSession.shared
        
        // Try to fetch a new joke
        // It might not work, so we use a do-catch block
        do {
            
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // Attempt to decode the raw data into a Swift structure
            // Takes what is in "data" and tries to put it into "currentJoke"
            //                                 DATA TYPE TO DECODE TO
            //                                         |
            //                                         V
            currentJoke = try JSONDecoder().decode(DadJoke.self, from: data)
            currentJokeAddedToFavourites = false
            
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")
            // Print the contents of the "error" constant that the do-catch block
            // populates
            print(error)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
