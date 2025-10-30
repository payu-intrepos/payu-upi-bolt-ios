//
//  ViewController.swift
//  PayUUPIBoltSwiftSampleApp
//
//  Created by Amit Salaria on 18/07/24.
//

import UIKit
import PayUUPIBoltUIKit
import PayUUPIBoltBaseKit

class ViewController: UIViewController {

    // MARK: - IBOutlets -

    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var saltTextField: UITextField!
    @IBOutlet weak var merchantNameTextField: UITextField!
    @IBOutlet weak var txnIdTextField: UITextField!
    @IBOutlet weak var reqIdTextField: UITextField!
    @IBOutlet weak var pluginTypeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var customerNameTextField: UITextField!
    @IBOutlet weak var vpaTextField: UITextField!
    @IBOutlet weak var isProductionSwitch: UISwitch!
    @IBOutlet weak var enforceManagementSV: UIStackView!
    @IBOutlet weak var enforceManagementJourneySwitch: UISwitch!
    @IBOutlet weak var enforceToHistorySwitch: UISwitch!
    @IBOutlet weak var enforceToUPIAccountSwitch: UISwitch!
    @IBOutlet weak var enforceToDisputeSwitch: UISwitch!
    @IBOutlet weak var enforceToDeRegisterSwitch: UISwitch!

    // MARK: - Default Values -

    var key = "<key>"
    var salt = "<salt>"
    var merchantName = "PayU"
    var txnId: String {
        "iOS\(Int64(Date().timeIntervalSince1970))"
    }
    var refId: String {
        "ref\(Int64(Date().timeIntervalSince1970))"
    }

    var pluginType = "BHIM"
    var amount = "1.00"
    var phone = "919876543210"
    var email = "upi@email.com"
    var userName = "ABC"
    var vpa = "9876543210@axisbank"
    var isProduction = true
    var surl: String = "https://cbjs.payu.in/sdk/success"
    var furl: String = "https://cbjs.payu.in/sdk/failure"
    var excludedBanksIINs : [String] = []
    
    private var enforcementCollection = [UISwitch]()
    private var landingScreen: PayUUPIBoltUIScreenType = .all
    // MARK: - UPI Bolt UI -
    
    var config: PayUUPIBoltUIConfig {
       let config = PayUUPIBoltUIConfig(
            merchantName: merchantNameTextField.text ?? "",
            merchantKey: keyTextField.text ?? "",
            phone: phoneTextField.text ?? "",
            email: emailTextField.text ?? "",
            refId: reqIdTextField.text ?? "",
            pluginTypes: [pluginTypeTextField.text?.uppercased() ?? ""],
            excludedBanksIINs: excludedBanksIINs,
            clientId: "Myntra",
            isProduction: isProductionSwitch.isOn
        )
        config.issuingBanks = ["AXIS"]
        return config
    }
    
    var helper: SDKHelper?
    
    // MARK: - Class Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialValues()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }


    // MARK: - Functions -

    func setInitialValues() {
        keyTextField.text = key
        saltTextField.text = salt
        merchantNameTextField.text = merchantName
        txnIdTextField.text = txnId
        pluginTypeTextField.text = pluginType
        amountTextField.text = amount
        phoneTextField.text = phone
        emailTextField.text = email
        vpaTextField.text = vpa
        customerNameTextField.text = userName
        isProductionSwitch.isOn = isProduction
        reqIdTextField.text = refId
        enforceManagementSV.isHidden = !enforceManagementJourneySwitch.isOn
        enforcementCollection = [enforceToHistorySwitch, enforceToUPIAccountSwitch, enforceToDisputeSwitch, enforceToDeRegisterSwitch]
        
        keyTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        saltTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        merchantNameTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        txnIdTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        reqIdTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        pluginTypeTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        amountTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        phoneTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        emailTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        vpaTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        customerNameTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(keyboardDoneTapped))
        
    }
    
    @objc func keyboardDoneTapped() {
        view.endEditing(true)
    }

    // MARK: - IBActions -
    
    @IBAction func enableEnforcementJourney(_ sender: UISwitch) {
        enforceManagementSV.isHidden = !sender.isOn
        landingScreen = .all
    }
    
    @IBAction func makeEnableEnforcement(_ sender: UISwitch) {
        //toggleEnforcementSwitch(for: sender)
        if sender.isOn {
            let _ = enforcementCollection.compactMap { switchButton in
                switchButton.isOn = sender == switchButton
            }
            if sender == enforceToHistorySwitch {
                landingScreen = .transactionHistory
            } else if sender == enforceToUPIAccountSwitch {
                landingScreen = .manageUPIAccounts
            } else if sender == enforceToDisputeSwitch {
                landingScreen = .dispute
            } else if sender == enforceToDeRegisterSwitch {
                landingScreen = .deregisterUPI
            }
        } else {
            sender.isOn = false
            landingScreen = .all
            enforceManagementSV.isHidden = true
            enforceManagementJourneySwitch.isOn = false
        }
    }
    
    @IBAction func pay(_ sender: UIButton) {
        initialiseHelperIfNeeded()
        let paymentParams = PayUUPIBoltPaymentParams(
            txnId: txnIdTextField.text ?? "",
            amount: amountTextField.text ?? "0.0",
            productInfo: "iPhone",
            firstName: customerNameTextField.text ?? "",
            surl: surl,
            furl: furl
        )
        helper?.registerAndPay(paymentParams)
    }
      
    @IBAction func manageAccountFlow(_ sender: UIButton) {
        initialiseHelperIfNeeded()
        helper?.manageAccountFlow(landingScreen)
    }
    
    @IBAction func resetClick(_ sender: UIButton) {
        helper?.reset()
        helper = nil
        reqIdTextField.text = refId
    }
    
    @IBAction func hdfcSampleAppClick(_ sender: UIButton) {
//        let vc = storyboard!.instantiateViewController(withIdentifier: "BoltAPIsTestViewController") as! BoltAPIsTestViewController
//        vc.view.backgroundColor = .clear
//        vc.key = keyTextField.text ?? ""
//        vc.salt = saltTextField.text ?? ""
//        vc.phone = phoneTextField.text ?? ""
//        vc.email = emailTextField.text ?? ""
//        vc.isProduction = isProductionSwitch.isOn
//        vc.merchantName = merchantNameTextField.text ?? ""
//        vc.txnId = txnIdTextField.text ?? ""
//        vc.pluginType = pluginTypeTextField.text ?? ""
//        vc.amount = amountTextField.text ?? "0.0"
//        vc.vpa = vpaTextField.text ?? ""
//        vc.userName = customerNameTextField.text ?? ""
//        vc.surl = surl
//        vc.furl = furl
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func initialiseHelperIfNeeded() {
        if helper == nil {
            helper = SDKHelper(parentVC: self, config: config)
            helper?.salt = saltTextField.text ?? ""
        }
        txnIdTextField.text = txnId
    }
}

extension UITextField {

    func addInputAccessoryView(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(
            x: 0.0,
            y: 0.0,
            width: UIScreen.main.bounds.size.width,
            height: 44.0
        ))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        doneItem.tintColor = .label
        toolBar.setItems([flexible, doneItem], animated: false)
        inputAccessoryView = toolBar
    }
}

