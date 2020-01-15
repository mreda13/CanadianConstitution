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
        
        textView.text = "\tCanadian Constitution was developed in order to have a handy offline version of Canada's Constitution; with easy navigation and no internet connectivity required.\n\n\tThis app was developed as part of a personal project and is not affiliated with any government agency or organisation.\n\n\tThe official text and notes of the Constitution Documents are available at: \nhttps://laws-lois.justice.gc.ca/eng/Const/Const_index.html\n\n\tIf you like the app, please leave a good review on the App Store and consider supporting me by checking out the Premium section. "
        
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
