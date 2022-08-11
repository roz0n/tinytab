//
//  HomeView.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/11/22.
//

import SwiftUI

struct HomeView: View {
  
  @StateObject var connectivity = WatchConnectivityManager()
  
  func transferUserInfo() {
    let data = ["phone": "Hello from the phone!"]
    connectivity.transferUserInfo(data)
  }
  
  func sendMessage() {
    let data = ["message": "The world is yours..."]
    connectivity.sendMessage(data)
  }
  
  func sendContext() {
    let data = ["context": "The iPhone context!"]
    connectivity.setContext(to: data)
  }
  
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
          Button("Transfer user info watch", action: transferUserInfo)
        }
        VStack {
          Text(connectivity.receivedMessageResponse ?? "")
          Button("Message watch", action: sendMessage)
        }
        VStack {
          Button("Set new context", action: sendContext)
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
