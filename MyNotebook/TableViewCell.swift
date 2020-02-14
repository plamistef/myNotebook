//
//  TableViewCell.swift
//  MyNotebook
//
//  Created by Plam Stefanova on 2/11/20.
//  Copyright © 2020 Plam Stefanova. All rights reserved.
//

import UIKit

protocol TableViewDelegate: class {
    func didRequestDelete (_ cell:TableViewCell)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var headlineLabel: UILabel!
    
    weak var delegate:TableViewDelegate?
    //var delegateObject: TableViewDelegate
    
   
    @IBAction func deleteHeadline(_ sender: Any) {
          
        print("button is clicked")
         if let delegateObject = self.delegate {
               print("we are in")
                delegateObject.didRequestDelete(self)
                print("all good")
            
         }else {
            print("delegate is nil")
        }
            }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
