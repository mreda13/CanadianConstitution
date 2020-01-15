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
    
    public static let Premium = "com.metwaly.CanadianConstitution.premium"    
    
    var productArray: [SKProduct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        purchaseButton.layer.cornerRadius = 18.0
        restorePurchaseButton.layer.cornerRadius = 18.0
        // Do any additional setup after loading the view.
        
        textView.text = "\tThe premium version of this application includes a search feature. More premium features will be added in upcoming versions of the app.\n\n\tIt is a one time payment of $3.99 CAD that will help fund further development and maintenance of this application."
        
        PaidProduct.store.requestProducts {(success, products) in
            if success {
                self.productArray = products ?? []
            }
        }
    }
    

    @IBAction func purchasePressed(_ sender: Any) {
        PaidProduct.store.buyProduct(productArray[0])
    }
    
    @IBAction func restorePurchasePressed(_ sender: Any) {
        PaidProduct.store.restorePurchases()
    }


}
