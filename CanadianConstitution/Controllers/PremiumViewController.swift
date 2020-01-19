//
//  PremiumViewController.swift
//  Canadian Constitution
//
//  Created by Mohamed Metwaly on 2019-12-11.
//

import UIKit
import StoreKit

class PremiumViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var purchaseButton: UIButton!
    
    @IBOutlet weak var restorePurchaseButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    public static let Premium = "com.metwaly.CanadianConstitution.premium"
    
    var productArray: [SKProduct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        purchaseButton.layer.cornerRadius = 18.0
        restorePurchaseButton.layer.cornerRadius = 18.0
        activityIndicator.alpha = 0
        textView.text = "\tThe premium version of this application includes a search feature. More premium features will be added in upcoming updates.\n\n\tIt is a one time payment of $3.99 CAD that will help fund further development and maintenance of this application."
        
        PaidProduct.store.requestProducts {(success, products) in
            if success {
                self.productArray = products ?? []
            }
        }
    }
    

    @IBAction func purchasePressed(_ sender: Any) {
    
        if IAPHelper.canMakePayments() == false {
            displayAlert(false, "noPayment")
        }
        else {
            
            PaidProduct.store.requestProducts {(success, products) in
                if success {
                    //print ("Number of products found: \(products?.count ?? 0)")
                }
                else {
                    DispatchQueue.main.async {
                        self.displayAlert(false, "internet")
                    }
                }
            }
            
            if productArray.count > 0 {
                PaidProduct.store.buyProduct(productArray[0]) { (result) in
                    switch result {
                    case .success(_):
                        self.displayAlert(true, "purchase")
                        break
                    case .failure(let error):
                        self.displayError(error)
                        break
                    }
                }
            }
        }
    }
    
    @IBAction func restorePurchasePressed(_ sender: Any) {
        
        PaidProduct.store.requestProducts {(success, products) in
            if success {
                //print ("Number of products found: \(products?.count ?? 0)")
            }
            else {
                DispatchQueue.main.async {
                    self.displayAlert(false, "internet")
                }
            }
        }
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        PaidProduct.store.restorePurchases { (result) in
            print(result)
                switch result {
                case .success(let success):
                    self.displayAlert(success,"restore")
                    break
                case .failure(let error):
                    self.displayError(error)
                    break
                }
        }
        activityIndicator.stopAnimating()
        activityIndicator.alpha = 0
    }
    
    func displayAlert(_ success:Bool,_ type:String) {
        var title = ""
        var message = ""
        if success{
            title = "Success"
            if  type == "restore" {
                message = "Premium account restored successfully!"
            }
            else {
                message = "Premium account purchased successfully. Thank you!"
            }
        }
        else {
            title = "Failed"
            if type == "internet" {
                message = "Please make sure you have an internet connection and try again."
            }
            else if type == "noPayment" {
                message = "You do not have permission to authorize a payment on the App Store."
            }
            else{
                message = "No purchases were found for this account."
            }
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Dismiss", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayError(_ error: Error){
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
