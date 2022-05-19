//
//  ViewController.swift
//  Apple Pay Prototype
//
//  Created by Muhammad Ewaily on 18/05/2022.
//

import PassKit
import UIKit

class ViewController: UIViewController {
    // Data Setup
    
    struct iPhone {
        var name: String
        var price: Double
    }
    
    let iPhoneData = [
        iPhone(name: "iPhone 13 Pro Max", price: 1399),
        iPhone(name: "iPhone 12 Pro Max", price: 1200),
        iPhone(name: "iPhone 11 Pro Max", price: 1100),
        iPhone(name: "iPhone XS Max", price: 900),
    ]
    
    // Storyboard outlets
    
    
    @IBAction func buyiPhoneTapped(_ sender: UIButton) {
        // Open Apple Pay purchase
        let iPhone = iPhoneData[0]
        let paymentItem = PKPaymentSummaryItem(label: iPhone.name, amount: NSDecimalNumber(value: iPhone.price))
        let paymentNetworks = [PKPaymentNetwork.masterCard, .visa, .amex, .discover]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            let request = PKPaymentRequest()
            request.currencyCode = "USD" // 1
            request.countryCode = "US" // 2
            request.merchantIdentifier = "merchant.com.ewaily.Apple-Pay-Prototype" // 3
            request.merchantCapabilities = PKMerchantCapability.capability3DS // 4
            request.supportedNetworks = paymentNetworks // 5
            request.paymentSummaryItems = [paymentItem] // 6
            
            
            guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
                displayDefaultAlert(title: "Error", message: "Unable to present Apple Pay authorization.")
                return
            }
            paymentVC.delegate = self
            self.present(paymentVC, animated: true, completion: nil)
            
        } else {
            displayDefaultAlert(title: "Error", message: "Unable to make Apple Pay transaction.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayDefaultAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }

    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        dismiss(animated: true, completion: nil)
        let vc = SuccessPaymentViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
