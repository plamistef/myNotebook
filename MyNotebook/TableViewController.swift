//
//  TableViewController.swift
//  MyNotebook
//
//  Created by Plam Stefanova on 2/9/20.
//  Copyright © 2020 Plam Stefanova. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, TableViewDelegate, ViewControllerDelegate {
    
    var currentHeadline:HeadlineItem!
    var headlineItems:[HeadlineItem]!
    
    func backButtonPressed(Title: String, Content: String) {
        
        
        if Title == "" {
                currentHeadline.title = "Untitled"
            print(currentHeadline.title)
        }else{
            currentHeadline.title = Title}
        
        //currentHeadline.title = Title
        currentHeadline.content = Content
        currentHeadline.saveItem()
       
        //add the headline to the array
        headlineItems.append(currentHeadline)
        
        tableView.reloadData()
        
    }
    
    func loadData() {
        headlineItems = [HeadlineItem]()
        headlineItems = DataManager.loadAll(HeadlineItem.self).sorted(by: {
            $0.modifiedAt < $1.modifiedAt
        })
        tableView.reloadData()
        
    }
    
    @IBAction func addBtnClicked  (_ sender: Any){
       // if currentHeadline != nil{
            //currentHeadline = HeadlineItem(title: "Untitled", content: "content", modifiedAt: Date(), itemIdentifier: UUID()) }
            //send data to viewcontroller
        
        //currentHeadline = newHeadline
        //print(currentHeadline.title)
       // newHeadline.saveItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return headlineItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.delegate = self
        
        let headlineItem = headlineItems[indexPath.row]
        cell.headlineLabel.text = headlineItem.title
        // Configure the cell...
        //cell.textLabel?.text = data[indexPath.row]
                        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    func didRequestDelete(_ cell: TableViewCell) {
       
        if let indexPath = tableView.indexPath(for: cell) {
            //remove the cell (headline item) from memory
            headlineItems[indexPath.row].deleteItem()
            //remove the cell (headline item) from the array
            headlineItems.remove(at: indexPath.row)
            //remove the cell (headline item) from TableView
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        currentHeadline = headlineItems[indexPath.row]
        performSegue(withIdentifier: "showHeadline", sender: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            viewController.delegate = self
            if segue.identifier == "showHeadline" {
                
                //viewController.currentHeadline = currentHeadline
            viewController.text = currentHeadline.content
            viewController.mainTitle = currentHeadline.title
            }
        
        if segue.identifier == "addHeadline" {
        
            currentHeadline = HeadlineItem.createItem(Title: "",Content: "Enter content here")
                       
            viewController.text = currentHeadline.content
            viewController.mainTitle = currentHeadline.title
        }
    }
    
    }
}
