//
//  FirstTableViewController.swift
//  Canadian Constitution
//
//  Created by Mohamed Metwaly on 2019-12-08.
//

import UIKit

class FirstTableViewController: UITableViewController {
    
    let oldAct = ["I. PRELIMINARY","II. UNION","III. EXECUTIVE POWER","IV. LEGISLATIVE POWER",
    "V. PROVINCIAL CONSTITUTIONS","VI. DISTRIBUTION OF LEGISLATIVE POWERS","VII. JUDICATURE",
    "VIII. REVENUES; DEBTS; ASSETS; TAXATION","IX. MISCELLANEOUS PROVISIONS","X. INTERCOLONIAL RAILWAY","XI. ADMISSION OF OTHER COLONIES","THE FIRST SCHEDULE","THE SECOND SCHEDULE",
    "THE THIRD SCHEDULE","THE FOURTH SCHEDULE","THE FIFTH SCHEDULE","THE SIXTH SCHEDULE"]
        
    var sections:[Section] = []
    
    func parseJSON() {
        let decoder = JSONDecoder()
        
        if let path = Bundle.main.path(forResource: "1867", ofType: "json") {
            do {
                let data = NSData(contentsOf: URL(fileURLWithPath: path))! as Data
                let jsonData = try decoder.decode(Array<Section>.self, from: data)
                sections = jsonData
            }
            catch {
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.backgroundColor = tableView.backgroundColor
        self.navigationController?.navigationBar.tintColor = .white
        parseJSON()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oldAct.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = oldAct[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        //cell.textLabel?.textColor = .white
        cell.textLabel?.font = .boldSystemFont(ofSize: 22.0)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "TextViewController") as! TextViewController
        print(sections.count)
        vc.section = sections[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
