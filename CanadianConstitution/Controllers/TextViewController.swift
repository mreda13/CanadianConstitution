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
    
    var section:Section!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let normalAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white , NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18) as Any] as [NSAttributedString.Key : Any]
        
        let selectedAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black , NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18) as Any] as [NSAttributedString.Key : Any]
        
        segmentedControl.setTitleTextAttributes(normalAttributes , for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttributes , for: .selected)
        
        let titleString = "<p style=\"text-align:center\"><font size = \"6.5 \" face = \"Helvetica\">" + (section.title ?? "") + "</font></p><hr>"
        let formattedText = titleString + "<font size = \"6\" face = \"Helvetica\">" + (section.text ?? "") + "</font>"
        textView.attributedText = formattedText.htmlToAttributedString
        
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        
        let titleString = "<p style=\"text-align:center\"><font size = \"6.5 \" face = \"Helvetica\">" + (section.title ?? "") + "</font></p><hr>"
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let formattedText = titleString + "<font size = \"6\" face = \"Helvetica\">" + (section.text ?? "") + "</font>"
            textView.attributedText = formattedText.htmlToAttributedString
        }
        else {
            let formattedText = "<font size = \"6\" face = \"Helvetica\">" + (section.notes ?? "") + "</font>"
            textView.attributedText = formattedText.htmlToAttributedString
        }
    }
}
