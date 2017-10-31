//
//  ApplePayHandler.swift
//  RNApplePayTest
//
//  Created by Clinton Medbery on 10/29/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import PassKit

@objc(ApplePayHandler)

class ApplePayHandler: NSObject {
  let SupportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
  let ApplePayTestMerchantID = ""
  
  @objc func canMakePayments(_ callback: RCTResponseSenderBlock) -> Void {
    let canPay = [
      "canPay" : PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: SupportedPaymentNetworks)
    ];
    callback([NSNull(), canPay])
  }
  
  @objc func makePayment() -> Void {
    let request = PKPaymentRequest()
    request.merchantIdentifier = ApplePayTestMerchantID
    request.supportedNetworks = SupportedPaymentNetworks
    request.merchantCapabilities = PKMerchantCapability.capability3DS
    request.countryCode = "US"
    request.currencyCode = "USD"
    //We should pass these in as params
    request.paymentSummaryItems = [
      PKPaymentSummaryItem(label: "Donation Cat 1", amount: 1.00),
      PKPaymentSummaryItem(label: "Donation Cat 2", amount: 0.50)
    ]
    let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
    applePayController.delegate = self
    //This is somewhat of a no no, we should be getting RCTRootView or whatever
    let vc = UIApplication.shared.keyWindow?.rootViewController
    vc?.present(applePayController, animated: true, completion: nil)
  }
  
}

extension ApplePayHandler: PKPaymentAuthorizationViewControllerDelegate {
  func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping ((PKPaymentAuthorizationStatus) -> Void)) {
    print(payment.token.paymentData)
    print("PAY ME")
    //This is where we would do our work. If successful, we send success.
    //We also need to send an event here
    completion(PKPaymentAuthorizationStatus.success)
  }
  
  func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
