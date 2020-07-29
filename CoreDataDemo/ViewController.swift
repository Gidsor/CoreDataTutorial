//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Vadim Denisov on 28.07.2020.
//  Copyright © 2020 Vadim Denisov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchPeople()
    }
    
    func fetchPeople() {
        
        // fetch the data from Core Data to display in the tableview
        do {
            self.items = try context.fetch(Person.fetchRequest())
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            
        } catch {
            
        }
        
    }

    @IBAction func addTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add Person", message: "What is their name?", preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            let textField = alert.textFields![0]
            guard textField.text != "" else { return }
            
            let newPerson = Person(context: self.context)
            newPerson.name = textField.text
            newPerson.age = Int64.random(in: 10...50)
            newPerson.gender = ["Male", "Female"].randomElement()!
            
            do {
                try self.context.save()
            } catch {
                
            }
            
            self.fetchPeople()
        }
        
        alert.addAction(submitButton)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        let person = items![indexPath.row]
        cell.textLabel?.text = "\(person.name ?? "No name") \(person.age) \(person.gender ?? "NaN")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = items![indexPath.row]
        
        let alert = UIAlertController(title: "Edit Person", message: "Edit name:", preferredStyle: .alert)
        alert.addTextField()
        
        let textField = alert.textFields![0]
        textField.text = person.name
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            person.name = textField.text
            do {
                try self.context.save()
            } catch {
                
            }
            self.fetchPeople()
        }
        
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, compleationHandler) in
            let person = self.items![indexPath.row]
            self.context.delete(person)
            
            do {
                try self.context.save()
            } catch {
                
            }
            
            self.fetchPeople()
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

