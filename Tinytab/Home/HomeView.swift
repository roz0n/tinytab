//
//  HomeView.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/11/22.
//

import SwiftUI

struct HomeView: View {
  @StateObject var connectivity = WatchConnectivityManager()
  
  var body: some View {
    GeometryReader { geo in
      ScrollView {
        VStack {
          Text("Connection status:")
          Text(connectivity.isLoggedIn ? "Connected" : "Not connected")
        }
      }
      .frame(width: geo.size.width, height: geo.size.height)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
