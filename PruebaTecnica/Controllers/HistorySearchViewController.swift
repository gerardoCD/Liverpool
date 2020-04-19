//
//  HistorySearchViewController.swift
//  PruebaTecnica
//
//  Created by Gerardo Castillo Duran  on 19/04/20.
//  Copyright © 2020 Gerardo Castillo Duran . All rights reserved.
//

import UIKit

protocol HistorySearchProtocol
{
    func changeSerch(type: String)
}

class HistorySearchViewController: UIViewController {
    
    var arraySeachHistory = [String] ()
    @IBOutlet weak var tableView: UITableView!
    var delegate:HistorySearchProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        vc.delegate = self
//        popover.popoverPresentationController?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()

    }
    
    
    func loadData(){
        
        if let array = UserDefaults.standard.array(forKey: "searchHistory"){
            
            arraySeachHistory = array as! [String]
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ProdcutViewController
        {
            let vc = segue.destination as? ProdcutViewController
            vc!.letterBack = sender as! String
        }
    }
    
}


extension HistorySearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arraySeachHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idcellHistory", for: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.textLabel?.text = arraySeachHistory[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hola \(indexPath.row)")
        self.navigationController?.popViewController(animated: false);
//        self.navigationController?.popoverPresentationController
//        self.navigationController?.popToRootViewController(animated: false)
//        self.presentedViewController?.dismiss(animated: true, completion: nil)
//        delegate?.changeSerch(type: arraySeachHistory[indexPath.row])
//        self.dismiss(animated: false, completion: nil)
        
//        dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "segueHome", sender: arraySeachHistory[indexPath.row])
    }
    
    
    
    
    
}



