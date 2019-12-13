//
//  SecondTableViewController.swift
//  Canadian Constitution
//
//  Created by Mohamed Metwaly on 2019-12-08.
//

import UIKit

class SecondTableViewController: UITableViewController {

    let newAct = ["I. CANADIAN CHARTER OF RIGHTS AND FREEDOMS", "II. RIGHTS OF THE ABORIGINAL PEOPLES OF CANADA", "III. EQUALIZATION AND REGIONAL DISPARITIES" ,"IV. CONSTITUTIONAL CONFERENCE" , "IV.I. CONSTITUTIONAL CONFERENCES", "V. PROCEDURE FOR AMENDING CONSTITUTION OF CANADA", "VI. AMENDMENT TO THE CONSTITUTION ACT, 1867","VII. GENERAL"]
    
    var sections:[Section] = []
    
    func parseJSON() {
        let decoder = JSONDecoder()
        
        if let path = Bundle.main.path(forResource: "1982", ofType: "json") {
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
        // #warning Incomplete implementation, return the number of rows
        return newAct.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = newAct[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.font = .boldSystemFont(ofSize: 22.0)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "TextViewController") as! TextViewController
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
