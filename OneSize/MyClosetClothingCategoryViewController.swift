//
//  MyClosetClothingCategoryViewController.swift
//  ClothesPIcker
//
//  Created by Shauna Ely on 7/4/17.
//  Copyright © 2017 Shauna Ely. All rights reserved.
//

import UIKit

class MyClosetClothingCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let tableView: UITableView = UITableView()
    var clothingCategory = ["Tops", "Pants", "Shoes", "Accessories", "Jackets", "Dresses", "Skirts"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return clothingCategory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myClosetCell")
        cell.textLabel?.text = clothingCategory[indexPath.row]
        print("created cell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if(editingStyle == UITableViewCellEditingStyle.delete){
            clothingCategory.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  

}
