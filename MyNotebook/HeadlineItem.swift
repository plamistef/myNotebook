//
//  HeadlineItem.swift
//  MyNotebook
//
//  Created by Plam Stefanova on 2/11/20.
//  Copyright © 2020 Plam Stefanova. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct HeadlineItem : Codable{
    var title:String
    var content: String
    var modifiedAt: Date
    var itemIdentifier: UUID

    func saveItem() {
        let db = Firestore.firestore()
        db.collection("HeadlineItems").addDocument(data: ["title":title,"content":content])
        
        //save file locally
        DataManager.save(self, with: itemIdentifier.uuidString)
        
    }
    
    func deleteItem() {
        DataManager.delete(itemIdentifier.uuidString)
    }
    
    static func createItem(Title:String,Content:String) -> HeadlineItem{
        return HeadlineItem(title:Title,content:Content,modifiedAt:Date(),itemIdentifier: UUID())
    }
    
}
