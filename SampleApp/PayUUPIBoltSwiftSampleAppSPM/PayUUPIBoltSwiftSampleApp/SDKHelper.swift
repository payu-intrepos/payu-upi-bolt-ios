//
//  SDKHelper.swift
//  PayUUPIBoltSwiftSampleApp
//
//  Created by Amit Salaria on 24/07/24.
//

import UIKit
import PayUUPIBoltUIKit
import PayUUPIBoltKit
import PayUUPIBoltBaseKit

class SDKHelper: PayUUPIBoltUIDelegate {
        
    // MARK: - UPI Bolt UI -
    var salt: String = ""
    
    private var boltUI: PayUUPIBoltUIInterface?
    private var parentVC: UIViewController?

    init(parentVC: UIViewController, config: PayUUPIBoltUIConfig) {
        self.parentVC = parentVC
        boltUI = PayUUPIBoltUI.initSDK(parentVC: parentVC, config: config, delegate: self)
    }

    func registerAndPay(_ paymentParams: PayUUPIBoltPaymentParams) {
        boltUI?.registerAndPay(paymentParams: paymentParams)
    }
    
    func manageAccountFlow(_ landingScreen: PayUUPIBoltUIScreenType = .all) {
        boltUI?.openUPIManagement(screenType: landingScreen)
    }
    
    func reset() {
        PayUUPIBoltUI.reset()
    }

}


extension SDKHelper: PayUUPIBoltHashDelegate {
    
    func generateHash(
        for param: [String: String],
        onCompletion: @escaping PayUUPIBoltHashGenerationCompletion) {
        let commandName = (param[PayUUPIBoltHashConstants.hashName] ?? "")
        let hashStringWithoutSalt = (param[PayUUPIBoltHashConstants.hashString] ?? "")
        let postSalt = param[PayUUPIBoltHashConstants.postSalt]
        // get hash for "commandName" from server
        // get hash for "hashStringWithoutSalt" from server
        
        // After fetching hash set its value in below variable "hashValue"
        var hashValue = ""
        if let postSalt = postSalt {
            let hashString = hashStringWithoutSalt + salt + postSalt
            hashValue = "generate hash of hashString from your server and add here"
        } else {
            let hashString = hashStringWithoutSalt + salt
            hashValue = "generate hash of hashString from your server and add here"
        }
        onCompletion([commandName: hashValue])
    }
    
    func onPayUSuccess(response: PayUUPIBoltResponse) {
        print("Success ", response)
        showAlert(title: "Success", response: response)
    }
    
    func onPayUFailure(response: PayUUPIBoltResponse) {
        print("Failure ", response)
        showAlert(title: "Failure", response: response)
    }
    
    func onPayUCancel(isTxnInitiated: Bool) {
        print("Cancel ", isTxnInitiated)
        showAlert(title: "Cancel ", response: isTxnInitiated)
    }
    
    func showAlert(title: String, response: Any?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            var text = ""
            if let response = response as? PayUUPIBoltResponse,
                let result = response.result as? Encodable {
                text += "Code - \(response.code)\n"
                text += "Message - \(response.message ?? "NIL")\n"
                text += "Response - "
                text += self.encodeToJSONString(result) ?? "NIL"
            } else if let response = response as? PayUUPIBoltResponse {
                text += "Code - \(response.code)\n"
                text += "Message - \(response.message ?? "NIL")\n"
                text += "Response - \(response.result ?? "NIL")"
            } else {
                text += String(describing: response ?? "NIL")
            }
            let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.parentVC?.present(alert, animated: true)
        }
    }

    func encodeToJSONString<T: Encodable>(_ object: T) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(object)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return "Encoding error: \(error)"
        }
    }

}
