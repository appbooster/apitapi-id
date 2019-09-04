# apitapi-id-ios

Framework for device token management that helps to use other ApiTapi frameworks.

## Installation

CocoaPods:

```
pod 'ApiTapiID'
```

## Usage

```
import ApiTapiID
```

### How to get the device token?

```
let deviceToken = ApiTapiID.deviceToken // if there is no stored device token generation occurs automatically
```

### How to reset the device token?

```
ApiTapiID.resetDeviceToken() // there will be no changes if useIDFA is true
```

or

```
class YourViewController: ShakeToResetDeviceTokenViewController {
	
	override func viewDidLoad() {
    	super.viewDidLoad()

    	shakeGestureIsEnabled = true // true by default
  	}

}

```
and make a shake gesture on `YourViewController` screen to reset the device token and exit the app

### How to use IDFA as device token?

```
ApiTapiID.useIDFA = true // false by default, if the new value differs old value it will reset the device token automatically
let deviceToken = ApiTapiID.deviceToken
```

### How to debug?

```
ApiTapiID.showDebug = true // false by default, to print all debugging info in the console
ApiTapiID.log = { text in } // to define your own log handler 
```

==================================================

You can see the example of usage in the attached project.