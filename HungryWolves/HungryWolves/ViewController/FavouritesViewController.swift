//
//  FavoritesViewController.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 10.08.2022.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var favouritesViewModel = FavouritesViewModel()
    
    var meal: FavouriteMeal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favouritesViewModel.loadFavouriteMeal()
        tabelView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection
                   section: Int) -> Int {
        return self.favouritesViewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tabelView.dequeueReusableCell(withIdentifier: "FavouritesCell", for: indexPath)
        guard let cell = dequeuedCell as? FavouritesTableViewCell else { return dequeuedCell }
        let meal =  self.favouritesViewModel.meals[indexPath.row]
        cell.showsReorderControl = true
        cell.updateFavouritesCell(with: meal)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.favouritesViewModel.removeFavouriteMeal(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
            FavouritesFileManager.saveToFile(meal: self.favouritesViewModel.meals)
        }
        deleteAction.backgroundColor = UIColor(red: 229, green: 229, blue: 229, a: 1)
        deleteAction.image = UIImage(named: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favouriteSegue", sender: self.favouritesViewModel.meals[indexPath.item].id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favouriteSegue" {
            let dequeuedSegue = segue.destination
            guard let destination = dequeuedSegue as? MealDetailsViewController else { return }
            destination.mealID = sender as? String ?? ""
        }
    }
    
}
