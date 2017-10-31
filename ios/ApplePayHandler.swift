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
  
}
