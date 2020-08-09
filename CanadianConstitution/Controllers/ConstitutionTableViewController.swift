//
//  ConstitutionTableViewController.swift
//  Canadian Constitution
//
//  Created by Mohamed Metwaly on 2020-08-09.
//

import UIKit

class ConstitutionTableViewController: UITableViewController {

    @IBOutlet weak var constitutionSelector: UISegmentedControl!
    
    private var numOfRows: Int?
    private var filteredSections:[Section] = []
    private var sections:[Section] = []

    let searchController = UISearchController(searchResultsController: nil)
    let normalAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white , NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18) as Any] as [NSAttributedString.Key : Any]
    
    let selectedAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black , NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18) as Any] as [NSAttributedString.Key : Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.backgroundColor = tableView.backgroundColor
        self.navigationController?.navigationBar.tintColor = .white
        constitutionSelector.setTitleTextAttributes(normalAttributes , for: .normal)
        constitutionSelector.setTitleTextAttributes(selectedAttributes , for: .selected)
        
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

    @IBAction func valueChanged(_ sender: Any) {
        numOfRows = constitutionSelector.selectedSegmentIndex == 0 ? oldAct.count : newAct.count
        parseJSON()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredSections.count : (numOfRows ?? oldAct.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if isFiltering{
            cell.textLabel?.text = filteredSections[indexPath.row].title
        }
        else{
            cell.textLabel?.text = constitutionSelector.selectedSegmentIndex == 0 ? oldAct[indexPath.row] : newAct[indexPath.row]
        }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.font = .boldSystemFont(ofSize: 22.0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TextViewController") as! TextViewController
        if isFiltering{
            vc.section = filteredSections[indexPath.row]
        }
        else{
            vc.section = sections[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: HELPER METHODS
    func parseJSON() {
        let decoder = JSONDecoder()
        
        let resource = constitutionSelector.selectedSegmentIndex == 0 ? "1867" : "1982"
        
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
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
    
    let oldAct = ["I. PRELIMINARY","II. UNION","III. EXECUTIVE POWER","IV. LEGISLATIVE POWER",
    "V. PROVINCIAL CONSTITUTIONS","VI. DISTRIBUTION OF LEGISLATIVE POWERS","VII. JUDICATURE",
    "VIII. REVENUES; DEBTS; ASSETS; TAXATION","IX. MISCELLANEOUS PROVISIONS","X. INTERCOLONIAL RAILWAY","XI. ADMISSION OF OTHER COLONIES","THE FIRST SCHEDULE","THE SECOND SCHEDULE",
    "THE THIRD SCHEDULE","THE FOURTH SCHEDULE","THE FIFTH SCHEDULE","THE SIXTH SCHEDULE"]
    
    let newAct = ["PART I", "PART II", "PART III" ,"PART IV" , "PART IV.I ", "PART V", "PART VI","PART VII"]
}

//MARK: SEARCH EXTENSION
extension ConstitutionTableViewController: UISearchResultsUpdating {
        
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
