//
//  ContentView.swift
//  DHT-ESP
//
//  Created by Thongchai Subsaidee on 31/3/2564 BE.
//

import SwiftUI

struct ContentView: View {
    let pages: [PagesModel] = pagesData
    var body: some View {
        TabView {
            ForEach(pages) { page in
                HomeView(page: page)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



