//
//  ContentView.swift
//  RickAndMortyAPI
//
//  Created by Eric on 05/06/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = CharacterViewModel(service: CharacterService())
    
    var body: some View {
        NavigationStack {
            switch vm.state {
                
            case .success(let data):
                List {
                    ForEach(data) { item in
                        Text(item.name)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Characters")
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .task {
            await vm.getCharacters()
        }
        .alert("Error", isPresented: $vm.hasError, presenting: vm.state) {
            detail in
            
            Button("Retry") {
                Task {
                    await vm.getCharacters()
                }
            }
        } message: { detail in
            if case let .failed(error) = detail {
                Text(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
