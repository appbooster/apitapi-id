//
//  ViewController.swift
//  ApiTapiIDExample
//
//  Created by Appbooster on 03/09/2019.
//  Copyright © 2019 Appbooster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    ApiTapiID.useIDFA = false
    print(ApiTapiID.deviceToken)
    ApiTapiID.resetDeviceToken()
    print(ApiTapiID.deviceToken)
  }

}

