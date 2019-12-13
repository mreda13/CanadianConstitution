//
//  PremiumViewController.swift
//  Canadian Constitution
//
//  Created by Mohamed Metwaly on 2019-12-11.
//

import UIKit

class PremiumViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var purchaseButton: UIButton!
    
    @IBOutlet weak var restorePurchaseButton: UIButton!
    
    public static let Premium = "com.metwaly.CanadianConstitution.premium"    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purchaseButton.layer.cornerRadius = 18.0
        restorePurchaseButton.layer.cornerRadius = 18.0
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
