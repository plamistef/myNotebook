//
//  HeadlineItem.swift
//  MyNotebook
//
//  Created by Plam Stefanova on 2/11/20.
//  Copyright © 2020 Plam Stefanova. All rights reserved.
//

import Foundation
import FirebaseFirestore

let db = Firestore.firestore()

struct HeadlineItem : Codable{
    var title:String
    var content: String
    var image: String
    var modifiedAt: Date
    var itemIdentifier: UUID
    

    func saveItem() {
       // let db = Firestore.firestore()
        db.collection("HeadlineItems").addDocument(data: ["title":title,"content":content])
        
        //save file locally
        DataManager.save(self, with: itemIdentifier.uuidString)
        
    }
    
    func deleteItem() {
        DataManager.delete(itemIdentifier.uuidString)
    }
    //todo fix this mpty string
    static func createItem(Title:String,Content:String) -> HeadlineItem{
        return HeadlineItem(title:Title,content:Content,image:"",modifiedAt:Date(),itemIdentifier: UUID())
    }
    
    func  getItems() -> Dictionary<String,Any> {
        
        var dictionary = Dictionary<String,Any>()
        db.collection("HeadlineItems").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //var title = document.data()
                    //retrievedItems.append()
                    dictionary = document.data() as [String : Any]
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    return dictionary
    }
}
