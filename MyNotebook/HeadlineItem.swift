//
//  HeadlineItem.swift
//  MyNotebook
//
//  Created by Plam Stefanova on 2/11/20.
//  Copyright © 2020 Plam Stefanova. All rights reserved.
//

import Foundation

struct HeadlineItem : Codable{
    var title:String
    var content: String
    var modifiedAt: Date
    var itemIdentifier: UUID

    func saveItem() {
        DataManager.save(self, with: itemIdentifier.uuidString)
    }
    
    func deleteItem() {
        DataManager.delete(itemIdentifier.uuidString)
    }
    
    static func createItem(Title:String,Content:String) -> HeadlineItem{
        return HeadlineItem(title:Title,content:Content,modifiedAt:Date(),itemIdentifier: UUID())
    }
    
}
