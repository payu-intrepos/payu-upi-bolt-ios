//
//  BoltSDKHelper.swift
//  PayUUPIBoltSwiftSampleApp
//
//  Created by Amrendra Roy on 12/08/24.
//

import UIKit
import PayUUPIBoltKit
import PayUUPIBoltBaseKit

class BoltSDKHelper: PayUUPIBoltDelegate {
    func onPayUHandleRetry(for errorCode: Int, errorMessage: String, onCompletion: @escaping PayUUPIBoltBaseKit.PayUUPIBoltRetryGenerationCompletion) {
        onCompletion(true)
    }
    
    
    // MARK: - UPI Bolt SDK
    
    var bolt: PayUUPIBoltInterface?
    var salt: String = ""
    var parentVC: UIViewController!

    init(parentVC: UIViewController, config: PayUUPIBoltBaseConfig) {
        self.parentVC = parentVC
        bolt = PayUUPIBolt.initSDK(config: config, delegate: self)
    }
    
    func testisUPIBoltSDKAvailable(pg: String, callback: @escaping PayUUPIBoltCallBack) {
        bolt?.isUPIBoltEnabled(callback: callback)
    }

    func testStartDeviceBinding(callback: @escaping PayUUPIBoltCallBack) {
        bolt?.checkDeviceStatus(parentVC: parentVC, callback: callback)
    }

    func testFetchBankList(callback: @escaping PayUUPIBoltCallBack) {
        bolt?.fetchBankList(callback: callback)
    }
    
    func testFetchLinkedAccounts(callback: @escaping PayUUPIBoltCallBack) {
        bolt?.fetchLinkedAccounts(callback: callback)
    }

    func testFetchAccountsWithIIn(
        iin: String,
        bankName: String,
        bankCode: String,
        vpa: String,
        requestType: String,
        callback: @escaping PayUUPIBoltCallBack
    ) {
        bolt?.fetchAccountsWithIIn(iin: "500007", bankName: "Mybank", bankCode: "AABD", bankId: "", vpa: vpa, requestType: requestType, isCCTxnEnabled: false, callback: callback)
    }

    func testFetchVPAProfiles(
        vpa: String,
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        bolt?.fetchVPAProfile(vpa: vpa, callback: completionHandler)
    }
    
    func testSaveVPA(
        vpa: String,
        name: String,
        nickName: String,
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        bolt?.saveVPA(vpa: vpa, name: name, nickName: nickName, callback: completionHandler)
    }

    func testDeleteVPA(
        vpa: String,
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        bolt?.deleteVPA(vpa: vpa, callback: completionHandler)
    }

    func testFetchRegisteredVPAList(
        vpa: String,
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        bolt?.fetchRegisteredVPAList(callback: completionHandler)
    }

    func testRegisterVpaAPI(
        vpa: String,
        accountId: String,
        accountName: String,
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        let accountDetail = PayUUPIBoltAccountDetail()
        accountDetail.vpa = vpa
        accountDetail.accountId = "81280"
        accountDetail.accountName = "ABC"
        accountDetail.accountNo = "878658XXXXXXXX8"
        accountDetail.ifsc = "AABD0000011"
        accountDetail.accountType = "SAVINGS"
        bolt?.setVPA(accountDetail: accountDetail, callback: completionHandler)
    }

    func testTransactionStatus(txnId: String, completionHandler: @escaping PayUUPIBoltCallBack) {
        bolt?.checkTransactionStatus(txnId: txnId, callback: completionHandler)
    }
    
    func testMakeTransaction(
        paymentParams: PayUUPIBoltPaymentParams,
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        bolt?.pay(
            parentVC: parentVC,
            paymentParams: paymentParams,
            callback: completionHandler
        )
    }
    
    func testGetDisputeTypeList(
        upiTransactionRefNo: String,
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        bolt?.fetchQueryTypeList(
            upiTransactionRefNo: upiTransactionRefNo,
            callback: completionHandler
        )
    }
    
    func testGetUserProfile(completionHandler: @escaping PayUUPIBoltCallBack) {
        bolt?.fetchVPAProfile(vpa:"",callback: completionHandler)
    }
    
    func testAddAccount(
        name: String,
        vpa: String,
        accountId: String,
        defaultVPAStatus: Bool,
        primaryAccount: String = "F", // T
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        let accountInfo = PayUUPIBoltAccountDetail()
        accountInfo.vpa = vpa
        accountInfo.accountId = accountId
        accountInfo.accountName = name
//        accountInfo.defVPAStatus = defaultVPAStatus
        accountInfo.defaultFlag = primaryAccount
        bolt?.addAccount(accountDetail: accountInfo, callback: completionHandler)
    }
    
    func testCheckBalanceAPI(
        vpa: String,
        accountId: String,
        accountNo: String,
        credentialLength: String,
        credentialType: String,
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        let accountDetail = PayUUPIBoltAccountDetail()
        accountDetail.vpa = vpa
        accountDetail.accountNo = "878658XXXXXXXX8"
        accountDetail.accountId = "81280"
        accountDetail.credentialLength = "6"
        accountDetail.credentialType = "NUM"
        bolt?.checkBalance(parentVC: parentVC, accountDetail: accountDetail, callback: completionHandler)
    }
    
    func testDeRegisterVPA(completionHandler: @escaping PayUUPIBoltCallBack) {
        bolt?.deregister(callback: completionHandler)
    }
    
    func testChangeMpin(
        vpa: String,
        accountId: String,
        accountNo: String,
        credentialLength: String,
        credentialType: String,
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        let accountDetail = PayUUPIBoltAccountDetail()
        accountDetail.vpa = vpa
        accountDetail.accountId = accountId
        accountDetail.accountNo = accountNo
        accountDetail.credentialLength = "6"
        accountDetail.credentialType = credentialType
        accountDetail.bankName = "Mypsp2"
        bolt?.changeMPIN(parentVC: parentVC, accountDetail: accountDetail, callback: completionHandler)
    }
    
    func testSetMpin(completionHandler: @escaping PayUUPIBoltCallBack) {
        let accountDetail = PayUUPIBoltAccountDetail()
        accountDetail.accountId = "56725"
        accountDetail.formatType = "FORMAT1"
//        bolt?.setMPIN(parentVC: parentVC, accountDetail: accountDetail, callback: completionHandler)
    }
    
    func testInitiateMPin(
        vpa: String,
        accountId: String,
        accountName: String,
        completionHandler: @escaping PayUUPIBoltCallBack
    ) {
        let accountDetail = PayUUPIBoltAccountDetail()
        accountDetail.vpa = "9876543210@hdfc"
        accountDetail.mbeba = "N" // MPIN flag represents if the MPIN is already set ( Y - Yes/ N - NO)
        accountDetail.aeba = "N" // (Y- Yes,it is aadhar enabled payment system / N - No, It is not aadhar enabled payment system )
//        accountDetail.formatType = "FORMAT2"
        
        accountDetail.accountId = "81280"
        accountDetail.accountName = "ABC"
        accountDetail.bankCode = "AABD"
        accountDetail.accountType = "SAVINGS"
        accountDetail.formatType = "FORMAT1"
        accountDetail.atmdLength = "0"
        accountDetail.bankName = "Mybank"
        accountDetail.bankId = "20369"
        accountDetail.formatType = "FORMAT1"
        accountDetail.credentialType = "NUM"
        accountDetail.credentialLength = "6"
        accountDetail.otpdType = "NUM"
        accountDetail.otpdLength = "6"
        accountDetail.iin = "500007"
        accountDetail.vpa = "9876543210@hdfc"
        accountDetail.accountNo = "878658XXXXXXXX8"
        accountDetail.refUrl = "https://www.upi.com"
        accountDetail.note = "Payment"

        accountDetail.aeba = "N"
        accountDetail.atmdLength = "6"
        accountDetail.ifsc = "AABD0000011"
        accountDetail.otpdLength = "6"
        accountDetail.otpdType = "NUM"
        accountDetail.mbeba = "Y"
        accountDetail.expiry = "0526"
        accountDetail.cardNo = "562653"
        accountDetail.cardType = "DEBIT"
        accountDetail.accountType = "SAVINGS"

        bolt?.setMPIN(parentVC: parentVC, accountDetail: accountDetail, callback: completionHandler)
    }
    
    func testRaiseDispute(completionHandler: @escaping PayUUPIBoltCallBack) {
        bolt?.raiseQuery(
            txnId: "payu1725349504760",
            refId: "payu1725349504760",
            amount: "1.00",
            query: "this is my dispute for 1.0 rs",
            callback: completionHandler
        )
    }
    
    func testTransactionHistory(completionHandler: @escaping PayUUPIBoltCallBack) {
        bolt?.fetchTransactionHistory(
            fromDate: "01/11/2024",
            toDate: "10/11/2024",
            callback: completionHandler
        )
    }
    
    func testSetDefaultAccount(vpa: String, completionHandler: @escaping PayUUPIBoltCallBack) {
        let account = PayUUPIBoltAccountDetail()
        account.accountId = "56725"
        account.vpa = vpa
        bolt?.removeAccount(
            accountDetail: account,
            requestType: "DA",
            callback: completionHandler
        )
    }
    
    func testRemoveAccount(vpa: String, completionHandler: @escaping PayUUPIBoltCallBack) {
        let account = PayUUPIBoltAccountDetail()
        account.accountId = "56725"
        account.vpa = vpa
        bolt?.removeAccount(
            accountDetail: account,
            requestType: "RA",
            callback: completionHandler
        )
    }
}

extension BoltSDKHelper: PayUUPIBoltHashDelegate {
    
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
    
}
