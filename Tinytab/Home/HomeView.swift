//
//  HomeView.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/11/22.
//

import SwiftUI

struct HomeView: View {
  
  @StateObject var connectivity = WatchConnectivityManager()
  
  func sendMessage() {
    let data = ["phone": "Hello from the phone!"]
    connectivity.transferUserInfo(data)
  }
  
  func sendContext() {}
  func sendFile() {}
  func sendComplication() {}
  
  var body: some View {
    GeometryReader { geo in
      ScrollView {
        VStack {
          Text("Connection status:")
          Text(connectivity.isWatchSessionActive ? "Connected" : "Not connected")
        }
        VStack {
          Text(connectivity.receivedTextWatch ?? "")
          Button("Message watch", action: sendMessage)
        }
        .padding()
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
