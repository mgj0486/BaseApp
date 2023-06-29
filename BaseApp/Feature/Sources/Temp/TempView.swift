//
//  TempView.swift
//  BaseApp
//
//  Created by dev team on 2023/06/29.
//

import SwiftUI
import CoreData
import Core

public struct TempView: View {
    public init() {}
    
    @StateObject var viewModel = TempViewModel()
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    public var body: some View {
        HStack(spacing: 0) {
            NavigationView {
                content
                    .navigationTitle("Temp")
                    .navigationBarItems(trailing: HStack {
                        Button(action: {
                            PersistenceManager.shared.removeAllEntityData(entityName: "Temp")
                            viewModel.send(event: .dataReload)
                        }) {
                            Text("테슷트")
                        }
                    })
            }
            .navigationViewStyle(.stack)
            .onAppear { viewModel.send(event: .onAppear) }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Text("idle")
        case .loading:
            ProgressView().progressViewStyle(CircularProgressViewStyle())
        case .loaded(let datas):
            list(of: datas)
        case .error(let error):
            Text(error.localizedDescription)
        }
    }
    
    @ViewBuilder
    func list(of diarys: [TempViewModel.ListItem]) -> some View {
        if diarys.isEmpty {
            Button(action: {
                viewModel.send(event: .dataReload)
            }) {
                HStack {
                    Text("추가해라")
                    Image(systemName: "pencil")
                }
            }
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 30), count: horizontalSizeClass == .compact ? 1 : 2), spacing: horizontalSizeClass == .compact ? 10 : 30) {
                    ForEach(diarys, id: \.self) { diary in
                        Button(action: {
                            
                        }) {
                            Text("asdf")
                        }
                    }
                }
                .padding(horizontalSizeClass == .compact ? 10 : 30)
            }
        }
    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        TempView()
    }
}
