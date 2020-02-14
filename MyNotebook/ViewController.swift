//
//  ViewController.swift
//  MyNotebook
//
//  Created by Plam Stefanova on 2/9/20.
//  Copyright © 2020 Plam Stefanova. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate{
    func backButtonPressed(Title: String, Content: String)
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var headlineTitle: UITextView!
    @IBOutlet weak var textView: UITextView!
    
   // @IBOutlet weak var headlineTitle: UILabel!
    var text:String = ""
    var mainTitle:String = ""
    //var currentHeadline:HeadlineItem!
    
    var delegate:ViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //textView.text = text
        //let headlineItem = HeadlineItem(title: "probvam se", content: "texetxetxte", modifiedAt: Date(), itemIdentifier: UUID())
        
        //headlineItem.saveItem()
        
       // let list = DataManager.loadAll(HeadlineItem.self)
        //print(list)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.text = text
        headlineTitle.text = mainTitle
    }
    /*
    @IBAction func unwindToTableView(_ unwindSegue: UIStoryboardSegue) {
           let sourceViewController = unwindSegue.source
           print("wtf")
       }
    */
    override func didMove(toParent parent: UIViewController?) {
           if(!(parent?.isEqual(self.parent) ?? false)) {
               print("Back Button Pressed!")
            if let delegateObject = self.delegate {
            print("we are in")
                //currentHeadline!.content = textView.text
              //  currentHeadline?.saveItem()
                delegateObject.backButtonPressed(Title: headlineTitle.text,Content: textView.text)
            //let test = HeadlineItem(title: "nil",content:textView.text,modifiedAt: Date(),itemIdentifier: UUID())
            //test.saveItem()
            
           }
       
       }
}
    /*
    @IBAction func addBtnClicked (_ sender: Any) -> Bool {
        let headlineItem = HeadlineItem(title: "Untitled", content: "", modifiedAt: Date(), itemIdentifier: UUID())
        return true
    }
 */
}



