//
//  TinytabApp.swift
//  Tinytab Watch Dev WatchKit Extension
//
//  Created by Arnaldo Rozon on 8/10/22.
//

import SwiftUI

@main
struct TinytabApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationView {
        HomeView()
        LandingView()
      }
    }
  }
}
