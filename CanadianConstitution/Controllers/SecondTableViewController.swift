//
//  SecondTableViewController.swift
//  Canadian Constitution
//
//  Created by Mohamed Metwaly on 2019-12-08.
//

import UIKit

class SecondTableViewController: UITableViewController {

    let newAct = ["PART I", "PART II", "PART III" ,"PART IV" , "PART IV.I ", "PART V", "PART VI","PART VII"]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredSections:[Section] = []
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
        if isFiltering{
            return filteredSections.count
        }
        else {
            return newAct.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if isFiltering{
            cell.textLabel?.text = filteredSections[indexPath.row].title
        }
        else {
            cell.textLabel?.text = newAct[indexPath.row]
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
        else {
            vc.section = sections[indexPath.row]

        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: SEARCH EXTENSION
extension SecondTableViewController: UISearchResultsUpdating {
        
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
