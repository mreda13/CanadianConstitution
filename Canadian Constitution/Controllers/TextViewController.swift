//
//  TextViewController.swift
//  Canadian Constitution
//
//  Created by Mohamed Metwaly on 2019-12-08.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let normalAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white , NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18) as Any] as [NSAttributedString.Key : Any]
        let selectedAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black , NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18) as Any] as [NSAttributedString.Key : Any]
        segmentedControl.setTitleTextAttributes(normalAttributes , for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttributes , for: .selected)
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
