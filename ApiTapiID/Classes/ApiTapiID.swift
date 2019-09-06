//
//  ApiTapiID.swift
//  ApiTapiID
//
//  Created by Appbooster on 03/09/2019.
//  Copyright © 2019 Appbooster. All rights reserved.
//

import Foundation
import AdSupport

public struct ApiTapiID {

  public static var useIDFA: Bool = false {
    didSet {
      if useIDFA != oldValue {
        resetDeviceToken()
      }
    }
  }
  
  public static var showDebug: Bool = false {
    didSet {
      State.showDebug = showDebug
    }
  }
  public static var log: ((String) -> Void)? {
    didSet {
      State.log = log
    }
  }

  public static var deviceToken: String {
    if let deviceToken = State.deviceToken {
      return deviceToken
    } else {
      var deviceToken = UUID().uuidString

      if useIDFA {
        debugAndLog("[ApiTapiID] Use IDFA for deviceToken")

        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
          deviceToken = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
          debugAndLog("[ApiTapiID] Advertising tracking is disabled")
        }
      }

      State.deviceToken = deviceToken

      return deviceToken
    }
  }

  public static func resetDeviceToken() {
    State.deviceToken = nil
  }

  // MARK: Service

  private static func debugAndLog(_ text: String) {
    if showDebug {
      #if DEBUG
      print(text)
      #endif
    }

    log?(text)
  }

}
