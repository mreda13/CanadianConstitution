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
        textView.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    }
}
