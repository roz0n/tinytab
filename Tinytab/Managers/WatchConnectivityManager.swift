//
//  WatchConnectivityManager.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/11/22.
//

import Foundation
import WatchConnectivity

final class WatchConnectivityManager: NSObject, ObservableObject {
  
  @Published var isWatchSessionActive: Bool = false
  @Published var receivedTextWatch: String?
  @Published var receivedTextPhone: String?
  @Published var receivedMessageResponse: String?
  @Published var receivedUpdatedApplicationContext: String?
  
  override init() {
    super.init()
    
    if WCSession.isSupported() {
      let session = WCSession.default
      
      session.delegate = self
      session.activate()
    }
  }
  
}

// MARK: - WatchConnectivityManager + WCSessionDelegate

extension WatchConnectivityManager: WCSessionDelegate {
  
  // MARK: - Context
  // NOTE: This should be used for application preferences
  
  func setContext(to data: [String: Any]) {
    let session = WCSession.default
    
    if session.activationState == .activated {
      do {
        try session.updateApplicationContext(data)
      } catch {
        self.receivedUpdatedApplicationContext = "Updating app context failed..."
      }
    }
  }
  
  func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
    DispatchQueue.main.async { [weak self] in
      self?.receivedUpdatedApplicationContext = "Fresh Application Context B)"
    }
  }
  
  // MARK: - UserInfo
  // WARNING: This only works on a physical device
  
  func transferUserInfo(_ userInfo: [String: Any]) {
    let session = WCSession.default
    
    if session.activationState == .activated {
      session.transferUserInfo(userInfo)
    }
  }
  
  func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
    DispatchQueue.main.async { [weak self] in
      if let watchMessageText = userInfo["watch"] as? String {
        self?.receivedTextWatch = watchMessageText
      } else if let phoneMessageText = userInfo["phone"] as? String {
        self?.receivedTextPhone = phoneMessageText
      }
    }
  }
  
  // MARK: - Messages
  // NOTE: These are "cheap"
  
  func sendMessage(_ data: [String: Any]) {
    let session = WCSession.default
    
    if session.isReachable {
      session.sendMessage(data) { [weak self] response in
        DispatchQueue.main.async {
          self?.receivedMessageResponse = "Received response"
        }
      }
    } else {
      print("Session not reachable...")
    }
  }
  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
    DispatchQueue.main.async {
      if let text = message["message"] as? String {
        self.receivedMessageResponse = text
        replyHandler([ "response": "Thanks for that!" ])
      }
    }
  }
  // MARK: - Session
  
#if os(iOS)
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    DispatchQueue.main.async {
      if activationState == .activated {
        if session.isWatchAppInstalled {
          print("[iOS] Watch app session successful")
          self.isWatchSessionActive = true
        }
      }
    }
  }
  
  func sessionDidBecomeInactive(_ session: WCSession) {
    DispatchQueue.main.async {
      print("[iOS] Watch connection session is inactive")
      self.isWatchSessionActive = false
    }
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
    DispatchQueue.main.async {
      print("[iOS] Watch session deactivated")
      self.isWatchSessionActive = false
    }
  }
#else
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    DispatchQueue.main.async {
      if activationState == .activated {
        print("[watchOS] iPhone found and session is active")
        self.isWatchSessionActive = true
      }
    }
  }
#endif
  
}
