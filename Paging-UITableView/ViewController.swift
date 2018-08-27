//
//  ViewController.swift
//  Paging-UITableView
//
//  Created by Kwikku Nusantara on 8/21/18.
//  Copyright © 2018 Kwikku Nusantara. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var foods = [Food(thumb: "rendang", name: "Rendang", country: "Indonesia"),
                 Food(thumb: "nasi_goreng", name: "Nasi Goreng", country: "Indonesia"),
                 Food(thumb: "sushi", name: "Sushi", country: "Japan"),
                 Food(thumb: "tom_yum_goong", name: "Tom Yum Goong", country: "Thailand"),
                 Food(thumb: "pad_thai", name: "Pad Thai", country: "Thailand"),
                 Food(thumb: "som_tam", name: "Som Tam", country: "Thailand"),
                 Food(thumb: "dim_sum", name: "Dim Sum", country: "Hongkong"),
                 Food(thumb: "ramen", name: "Ramen", country: "Japan"),
                 Food(thumb: "peking_duck", name: "Peking Duck", country: "China"),
                 Food(thumb: "massaman_curry", name: "Massaman Curry", country: "Thailand")]
    
    var moreFoods: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.moreFoods.append(contentsOf: self.foods)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        // do network request here
        
        self.tableView.showLoadingFooter()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            self.foods.append(contentsOf: self.moreFoods)
            self.tableView.reloadData()
            
            self.tableView.hideLoadingFooter()
        }
    }

}

struct Food {
    
    var thumb = String()
    var name = String()
    var country = String()
    
}

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let food = foods[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.thumbImageView.image = UIImage(named: food.thumb)
        
        cell.nameLabel?.text = food.name
        cell.countryLabel.text = food.country
        
        return cell
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if !tableView.isLoadingFooterShowing() {
                    loadData()
                }
            }
        }
    }
}
