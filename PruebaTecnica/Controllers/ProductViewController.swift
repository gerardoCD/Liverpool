//
//  HistorySearchViewController.swift
//  PruebaTecnica
//
//  Created by Gerardo Castillo Duran  on 19/04/20.
//  Copyright © 2020 Gerardo Castillo Duran . All rights reserved.
//

import UIKit

class ProdcutViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var btnHistory: UIButton!
    
    
    var productsArray = [Record]()
    
    
    var searching = false
    var searchValue = ""
    var letterBack  = ""
    let imageCache = NSCache<NSString, UIImage>()
    
    
    
    var searchArray = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let vc = HistorySearchViewController()
        vc.delegate = self
//        tableView.isUserInteractionEnabled = false
//        self.tableView.separatorStyle = .none
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadInfo() 

    }
    
    
    func loadInfo() {
        
        if letterBack == ""{
            letterBack = "computadora"
            self.searchBar.enable()
            btnHistory.isEnabled = true
            
        } else {
            self.searchBar.disable()
            btnHistory.isEnabled = false
        }

        API.shared.getProduct(searchString: letterBack) { (products, error) in
            if error == nil {
                
                self.productsArray = products?.plpResults.records as! [Record]
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(self.productsArray)
            }
        }
    }
    
}

extension ProdcutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(productsArray.count)
        
        return productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "idcell", for: indexPath) as! ProductTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.priceLabel.text = "Price: $ " + String(productsArray[indexPath.row].listPrice)
//        DispatchQueue.main.async {
//            let url = URL(string: self.productsArray[indexPath.row].smImage)
//            let data = try? Data(contentsOf: url!)
//            let image  = UIImage(data: data!)
//            cell.imgProduct.image = image
//        }
        
        let url = URL(string:self.productsArray[indexPath.row].smImage)
        downloadImage(url: url!) { (image, error) in
            if error == nil {
                cell.imgProduct.image = image
            }
        }
        cell.descriptionLabel.text =   productsArray[indexPath.row].productDisplayName
        return cell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "idcell", for: indexPath) as! ProductTableViewCell
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
////        cell.layer.masksToBounds = true
////        cell.layer.cornerRadius = 10
////        cell.layer.borderWidth = 2
////        cell.layer.shadowOffset = CGSize(width: -1, height: 1)

    }
       
}



extension ProdcutViewController: UISearchBarDelegate{
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchValue = searchText
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if (searchValue == "") {
            searchValue = "computadora"
        }else {
            if var array = UserDefaults.standard.array(forKey: "searchHistory"){
                array.append(searchValue)
                print(array)
                UserDefaults.standard.setValue(array, forKey: "searchHistory")
            }else{
                var array = [String]()
                array.append(searchValue)
                UserDefaults.standard.setValue(array, forKey: "searchHistory")
            }
        }
        
        API.shared.getProduct(searchString:searchValue) { (products, error) in
            if error == nil {
                
                self.productsArray = products?.plpResults.records as! [Record]
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(self.productsArray)
            }
        }

        print("Termine")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Inicie")
    }
    
    func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            DispatchQueue.main.async {
                do{
                    let data = try! Data(contentsOf: url)
                    let image  = UIImage(data: data)
                    completion(image, nil)
                }catch let error {
                    completion(nil, error)
                } 
//                cell.imgProduct.image = image
            }
        }
    }
}


extension ProdcutViewController: HistorySearchProtocol{
    func changeSerch(type: String) {
        letterBack = type
    }
    
    
}





