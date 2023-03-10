//
//  ViewController.swift
//  Meal App
//
//  Created by Donald Dang on 3/5/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let nw = NetworkingManager()
    let destinationVC = MealDetailController()
    var mealsArr: [Meals] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        //Call our generic parseData function with result of type "Meals"
        nw.parseData(from: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert", resultType: Meals.self) { (mealsArray: [Meals]?) in
            //put in main thread (rather than background thread)
            DispatchQueue.main.async {
                if let mealsArray = mealsArray {
                    //sort the array if necessary
                    self.mealsArr.sort(by: {$0.strMeal < $1.strMeal})
                    self.mealsArr = mealsArray
                    //reload tableView to load new data
                    self.tableView.reloadData()
                } else {
                    print("Error fetching Meals")
                }
            }
        }
        
        
    }
    //segue to MealDetailController passing in the selectedID to use in our JSON response.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let destination = segue.destination as! MealDetailController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.selectedID = self.mealsArr[selectedIndexPath.row].idMeal //pass idMeal to DetailViewController
        }
    }

}
//standard tableView stuff; define cellforrowat (what we want in the cells, amount of cells, didSelectrowAt to segue
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.mealsArr[indexPath.row].strMeal
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealsArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        destinationVC.selectedID = self.mealsArr[indexPath.row].idMeal
        performSegue(withIdentifier: "segue", sender: self)
    }
    
}

