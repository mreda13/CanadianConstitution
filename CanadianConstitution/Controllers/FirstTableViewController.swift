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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredSections:[Section] = []
    var sections:[Section] = []
    
    // MARK: HELPER METHODS
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
    
    //MARK: SEARCH HELPER METHODS

    
    //MARK: SYSYEM METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.backgroundColor = tableView.backgroundColor
        self.navigationController?.navigationBar.tintColor = .white
        parseJSON()
        
        if PaidProduct.store.isProductPurchased(PaidProduct.premium){
            setupSearch()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if PaidProduct.store.isProductPurchased(PaidProduct.premium){
            setupSearch()
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredSections.count
        }
        else{
            return oldAct.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if isFiltering{
            cell.textLabel?.text = filteredSections[indexPath.row].title
        }
        else{
            cell.textLabel?.text = oldAct[indexPath.row]
        }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.font = .boldSystemFont(ofSize: 22.0)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "TextViewController") as! TextViewController
        if isFiltering{
            vc.section = filteredSections[indexPath.row]
        }
        else{
            vc.section = sections[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: SEARCH EXTENSION
extension FirstTableViewController: UISearchResultsUpdating {
        
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    func setupSearch(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search ..."
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.tintColor = .black
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
    }
    
    func filterResults(_ searchText:String){
        filteredSections = sections.filter({ (section:Section) -> Bool in
            return section.text?.lowercased().contains(searchText.lowercased()) ?? false || section.notes?.lowercased().contains(searchText.lowercased()) ?? false ||
                section.title?.lowercased().contains(searchText.lowercased()) ?? false
        })
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterResults(searchBar.text!)
    }
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
