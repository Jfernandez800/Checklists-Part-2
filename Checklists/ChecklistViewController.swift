//
//  ViewController.swift
//  Checklists
//
//  Created by James Fernandez on 8/24/23.
//
//------------------------------Chapter 9 & 10--------------------------------
import UIKit

//change object so it reads the table view controller
class ChecklistViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    //create array list.
    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Enables large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //assign strings for the list to an array.
        let item1 = ChecklistItem()
          item1.text = "Walk the dog"
          items.append(item1)
          let item2 = ChecklistItem()
          item2.text = "Brush my teeth"
          item2.checked = true
          items.append(item2)
          let item3 = ChecklistItem()
          item3.text = "Learn iOS development"
          item3.checked = true
          items.append(item3)
          let item4 = ChecklistItem()
          item4.text = "Soccer practice"
          items.append(item4)
          let item5 = ChecklistItem()
          item5.text = "Eat ice cream"
          items.append(item5)
    }
    
    // MARK: - Table View Data Source
    //this method tells how many rows are in table.
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
      return items.count
    }
    
    //This method will call the method and pass the array then it will return the info to the table.
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath)
      let item = items[indexPath.row]
      configureText(for: cell, with: item)
      configureCheckmark(for: cell, with: item)
      return cell
    }
    
    // MARK: - Table View Delegate
    //if user taps row it will select the item.
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
    if let cell = tableView.cellForRow(at: indexPath) {
        let item = items[indexPath.row]
        item.checked.toggle()
        configureCheckmark(for: cell, with: item)
    }
      tableView.deselectRow(at: indexPath, animated: true)
    }
        
    //this method gives the item the checkmark or not.
    func configureCheckmark(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ){
      // Replace full method implementation
      if item.checked {
        cell.accessoryType = .checkmark
    } else {
        cell.accessoryType = .none
          }
        }
    
    //sets the item text to label.
    func configureText(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ){
    let label = cell.viewWithTag(1000) as! UILabel
      label.text = item.text
    }
    
    //------------------------------Chapter 11--------------------------------
    
    // MARK: - Actions
    //this will create the new checklistItem and add it to the data model.
    @IBAction func addItem() {
        //we need to know the index in order to know where to place the new item.
        let newRowIndex = items.count
        //creates new ChecklistItem object and appends it to the end of the array.
        let item = ChecklistItem()
        item.text = "I am a new row"
        items.append(item)
        //Tells Table view about new row so it can be added.
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        //creates temp. array to hold the one index-path item.
        let indexPaths = [indexPath]
        //inserts new row.
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    //This will enable swipe to delete.
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ){
    // deletes the Item from the array.
      items.remove(at: indexPath.row)
    // 2
      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}
