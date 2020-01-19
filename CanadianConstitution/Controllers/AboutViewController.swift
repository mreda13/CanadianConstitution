//
//  AboutViewController.swift
//  Canadian Constitution
//
//  Created by Mohamed Metwaly on 2019-12-10.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = "\tCanadian Constitution was developed to provide an easily accessible offline version of Canada's Constitution.\n\n\tThis app was developed as part of a personal project and is not affiliated with any government agency or organisation.\n\n\tThe official text and notes of the Constitution Documents are available at: \nhttps://laws-lois.justice.gc.ca/eng/Const/Const_index.html .\n\n\tIf you like the app, please leave a good review on the App Store and consider checking out the Premium section for additional features. "
        
        textView.dataDetectorTypes = .link
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
