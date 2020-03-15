//
//  CloudStorage.swift
//  MyNotebook
//
//  Created by Plam Stefanova on 3/15/20.
//  Copyright © 2020 Plam Stefanova. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class CloudStorage {
    
    private static var list = [HeadlineItem]()
    private static let db = Firestore.firestore()
    private static let storage = Storage.storage() // get the instance
    private static let notes = "notes"
    
    static func downloadImage(name:String, vc:ViewController){
        print("download called...")
        let imgRef = storage.reference(withPath: name) // get "filehandle"
        imgRef.getData(maxSize: 4000000) { (data, error) in
            if error == nil {
                print("success downloading image !")
                let img = UIImage(data: data!)
                DispatchQueue.main.async { // prevent background thread from
                    // interrupting the main thread, which handles user input
                    vc.imageView.image = img
                }
            } else {
                print("some error downloading \(error.debugDescription)")
            }
            
        }
        
    }
    
    static func getSize() -> Int{
        return list.count
    }
    
    static func getNoteAt(index:Int) -> HeadlineItem {
        return list[index]
    }
    
    static func startListener(tableView:UITableView){
        print("starting listener")
        db.collection(notes).addSnapshotListener { (snap, error) in
            if error == nil {
                self.list.removeAll() // clears the list
                for note in snap!.documents {
                    let map = note.data()
                    let head = map["Title"] as! String
                    let body = map["Content"] as! String
                    let image = map["Image"] as? String ?? "empty"
                   // let newNote = HeadlineItem(id: note.documentID, head: head, body: body, img:image)
                    let newNote = HeadlineItem(title: head, content: body, image: image, modifiedAt: Date(), itemIdentifier: UUID())
                    self.list.append(newNote)
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    
    static func deleteNote(id:String){
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
    static func updateNote(index:Int, head:String, body:String){
        let note = list[index]
      
        let docRef = db.collection(notes).document(note.itemIdentifier.uuidString)
        var map = [String:String]()
        map["Title"] = head
        map["Content"] = body
        docRef.setData(map)
    }
    
}
