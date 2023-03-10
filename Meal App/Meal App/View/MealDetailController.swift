//
//  MealDetailController.swift
//  Meal App
//
//  Created by Donald Dang on 3/5/23.
//

import UIKit

class MealDetailController: UIViewController {
    
    
    var selectedID: String?
    
    var urlString: String?
    
    var mealDetail: [Meals] = []
    
    let nw = NetworkingManager()
    
    @IBOutlet weak var dessertName: UINavigationBar!
    @IBOutlet var ingredients: [UILabel]!
    @IBOutlet var quantities: [UILabel]!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var instructions: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = selectedID {
            nw.parseData(from: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)", resultType: Meals.self) { (mealsArr: [Meals]?) in
                if let mealsArr = mealsArr {
                    self.mealDetail = mealsArr
                    DispatchQueue.main.async {
                        if let meal = self.mealDetail.first {
                            self.mealName.text = meal.strMeal
                            self.instructions.text = meal.strInstructions
                            for (index, ingredient) in meal.allIngredients.enumerated() {
                                self.ingredients[index].text = ingredient
                                self.ingredients[index].isHidden = ingredient.isEmpty
                            }
                            for (index, quantity) in meal.allQuantities.enumerated() {
                                self.quantities[index].text = quantity
                                self.quantities[index].isHidden = quantity.isEmpty
                            }
                        }
                    }
                }
            }
        } else {
            print("selectedID not found!")
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        instructions.isUserInteractionEnabled = true
        instructions.addGestureRecognizer(tapGesture)
    }
    
    @objc func labelTapped(sender: UITapGestureRecognizer) {
        let label = sender.view as! UILabel
        label.font = UIFont.systemFont(ofSize: 25)
    }
    
}

extension Meals {
    var allIngredients: [String] {
        return [strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20].compactMap({$0})
    }
    var allQuantities: [String] {
        return [strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20].compactMap({$0})
    }
}
