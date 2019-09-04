//
//  ShakeToResetDeviceTokenViewController.swift
//  ApiTapiID
//
//  Created by Appbooster on 04/09/2019.
//  Copyright © 2019 Appbooster. All rights reserved.
//

import UIKit

open class ShakeToResetDeviceTokenViewController: UIViewController {

  open var shakeGestureIsEnabled: Bool = true

  // MARK: UIResponder

  override open var canBecomeFirstResponder: Bool {
    return true
  }

  override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    if shakeGestureIsEnabled && motion == .motionShake {
      ApiTapiID.resetDeviceToken()

      let alertController = UIAlertController(title: "Device token was reseted. The app will be closed by tap on OK button.", message: nil, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
        exit(0)
      }
      alertController.addAction(alertAction)

      present(alertController, animated: true, completion: nil)
    }
  }

  // MARK: UIViewController

  override open func viewDidLoad() {
    super.viewDidLoad()

    becomeFirstResponder()
  }

}
