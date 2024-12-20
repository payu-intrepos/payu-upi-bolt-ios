//
//  BoltAPIsTestViewController.swift
//  PayUUPIBoltSwiftSampleApp
//
//  Created by Amrendra Roy on 12/08/24.
//

import UIKit
import PayUUPIBoltKit
import PayUUPIBoltBaseKit

class BoltAPIsTestViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var key = ""
    var salt = ""
    var userName = ""
    var email = ""
    var phone = ""
    var merchantName = ""
    var isProduction = true
    var txnId = ""
    var pluginType = ""
    var amount = ""
    var vpa = ""
    var surl: String = "https://cbjs.payu.in/sdk/success"
    var furl: String = "https://cbjs.payu.in/sdk/failure"
    var excludedBanksIINs : [String] = []
    
    lazy var boltSDKHelper: BoltSDKHelper = {
        let helper = BoltSDKHelper(
            parentVC: self,
            config: config
        )
        helper.salt = salt
        return helper
    }()
    
    lazy var config: PayUUPIBoltBaseConfig = {
        PayUUPIBoltBaseConfig(
            merchantName: merchantName,
            merchantKey: key,
            phone: phone,
            email: email,
            refId: "",
            pluginTypes: [pluginType],
            excludedBanksIINs: excludedBanksIINs,
            clientId: "MYNTRA",
            isProduction: isProduction
        )
    }()
                
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Check device status
    @IBAction func checkUPIAvailableStatus(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testisUPIBoltSDKAvailable(pg: pluginType) { response in
            self.updateLayout(with: response)
        }
    }
    
    @IBAction func checkDeviceStatus(_ sender: UIButton) {
        showIndicator()
        self.boltSDKHelper.testStartDeviceBinding { response in
            self.updateLayout(with: response)
        }
    }

    // MARK: - GetBankList
    @IBAction func getBankList(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testFetchBankList { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - Get upi List of Accounts
    @IBAction func getUPIListOfAccount(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testFetchAccountsWithIIn(
            iin: "500004",
            bankName: "Mypsp2",
            bankCode: "AABF",
            vpa: vpa,
            requestType: "R"
        ) { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - Get upi List of Accounts
    @IBAction func linkedAccount(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testFetchLinkedAccounts { response in
            self.updateLayout(with: response)
        }
    }
    
    @IBAction func fetchRegisteredVPAList(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testFetchRegisteredVPAList(vpa: vpa) { response in
            self.updateLayout(with: response)
        }
    }

    @IBAction func deleteVPA(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testDeleteVPA(vpa: vpa) { response in
            self.updateLayout(with: response)
        }
    }

    @IBAction func saveVPA(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testSaveVPA(vpa: vpa, name: "Name", nickName: "Name") { response in
            self.updateLayout(with: response)
        }
    }

    @IBAction func fetchVPAProfiles(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testFetchVPAProfiles(vpa: vpa) { response in
            self.updateLayout(with: response)
        }
    }

    // MARK: - Register VPA
    @IBAction func registerVPA(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testRegisterVpaAPI(
            vpa: vpa,
            accountId: "56686",
            accountName: userName
        ) { response in
            self.updateLayout(with: response)
        }
    }

    // MARK: - Transaction Status
    @IBAction func transactionStatus(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testTransactionStatus(
            txnId: txnId,
            completionHandler: { response in
                self.updateLayout(with: response)
            })
    }
    
    // MARK: - Make Transaction
    @IBAction func makePayment(_ sender: UIButton) {
        showIndicator()
        let paymentParams = PayUUPIBoltPaymentParams(
            txnId: txnId,
            amount: amount,
            productInfo: "iPhone",
            firstName: userName,
            surl: surl,
            furl: furl
        )

        var payerAccountDetail = PayUUPIBoltAccountDetail()
        payerAccountDetail.accountId = "81280"
        payerAccountDetail.accountName = "ABC"
        payerAccountDetail.bankCode = "AABD"
        payerAccountDetail.accountType = "SAVINGS"
        payerAccountDetail.formatType = "FORMAT1"
        payerAccountDetail.atmdLength = "0"
        payerAccountDetail.bankName = "Mybank"
        payerAccountDetail.bankId = "20369"
        payerAccountDetail.formatType = "FORMAT1"
        payerAccountDetail.credentialType = "NUM"
        payerAccountDetail.credentialLength = "6"
        payerAccountDetail.otpdType = "NUM"
        payerAccountDetail.otpdLength = "6"
        payerAccountDetail.iin = "500007"
        payerAccountDetail.vpa = "9876543210@hdfc"
        payerAccountDetail.accountNo = "878658XXXXXXXX8"
        payerAccountDetail.refUrl = "https://www.upi.com"
        payerAccountDetail.note = "Payment"
        
//        var payeeAccountDetail = PayUUPIBoltPayeeAccountDetail()
//        payeeAccountDetail.ifsc = "HDFC0000273"
//        payeeAccountDetail.vpaType = "VA"
        /*
         VA - Pay Using Virtual Address & Pay using VPA QR code
         AC - Payment using Account & Pay using Account IFSC QR
         AD - Pay using Aadhar number/
         MI - Pay to mobile number, MMID of the payee
         */
        paymentParams.payerAccountDetail = payerAccountDetail
        
        boltSDKHelper.testMakeTransaction(paymentParams: paymentParams) { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - Get Dispute Type List
    @IBAction func getDisputeTypeList(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testGetDisputeTypeList(upiTransactionRefNo: "iOS240819124422") { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - Get User Profile
    @IBAction func getUpiUserProfile(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testGetUserProfile { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - Add Account
    @IBAction func addAccount(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testAddAccount(
            name: userName,
            vpa: vpa,
            accountId: "56725",
            defaultVPAStatus: false,
            primaryAccount: "F"
        ) { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - Check Balance
    @IBAction func checkBalance(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testCheckBalanceAPI(
            vpa: "9876543210@hdfc",
            accountId: "69830",
            accountNo: "XXXXXX254769",
            credentialLength: "6",
            credentialType: "NUM") { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - changeMPIN
    @IBAction func changeMPIN(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testChangeMpin(
            vpa: "9876543210@hdfc",
            accountId: "69830",
            accountNo: "XXXXXXXXXX254769",
            credentialLength: "6",
            credentialType: "NUM") { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - raise Dispute
    @IBAction func raiseDispute(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testRaiseDispute { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - Transaction History
    @IBAction func transactionHistory(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testTransactionHistory { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - Set Default Account
    @IBAction func setDefaultAccount(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testSetDefaultAccount(vpa: vpa) { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - Remove Account
    @IBAction func removeAccount(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testRemoveAccount(vpa: vpa) { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - set MPin
    @IBAction func setMPin(_ sender: UIButton) {
        showIndicator()
        boltSDKHelper.testSetMpin { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - initiate MPIN
    @IBAction func initiateMPIN(_ sender: UIButton) {
        showIndicator()
        
        boltSDKHelper.testInitiateMPin(vpa: vpa, accountId: "81280", accountName: "ABC") { response in
            self.updateLayout(with: response)
        }
    }
    
    // MARK: - Add Account
    @IBAction func deregisterVPA(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert!", message: "Are you sure?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) {[weak self] _ in
            self?.showIndicator()
            self?.boltSDKHelper.testDeRegisterVPA() { response in
                self?.updateLayout(with: response)
            }
        }
        let no = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(yes)
        alert.addAction(no)
        self.present(alert, animated: true)
    }
}

// MARK: - Private methods
extension BoltAPIsTestViewController {
    
    private func showIndicator() {
        DispatchQueue.main.async {
            self.indicator?.startAnimating()
        }
    }
    
    private func hideIndicator() {
        DispatchQueue.main.async {
            self.indicator?.stopAnimating()
        }
    }
    
    private func updateLayout(with response: PayUUPIBoltResponse) {
        DispatchQueue.main.async {
            self.hideIndicator()
            self.codeLabel?.text = "Code: \(response.code)"
            self.messageLabel?.text = "Message: \(String(describing: response.message))"
            var text = ""
            text += "Code - \(response.code)\n"
            text += "Message - \(response.message ?? "NIL")\n"
            text += "Response - "
            let result = response.result
            if let result = result as? Encodable {
                text += self.encodeToJSONString(result) ?? "NIL"
            } else {
                text += String(describing: result ?? "NIL")
            }
            self.resultLabel?.text = text
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
