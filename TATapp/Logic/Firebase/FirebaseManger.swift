//
//  FirebaseManger.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-06-20.
//

import SwiftUI
import Firebase


class FirebaseManager<T>{
    
    var dictionaryRows: [T]?
    var countRow: Int = 0
    let collectionRef: FCollectionReference
    
    init(fCollection: FCollectionReference) {
        self.collectionRef = fCollection
    }
    
    func getCollectionRows(completion: @escaping (_ content:[Any]?) -> Void) {
        var returnRows : [Any] = []
        
        FirebaseReference(collectionRef)
            //.order(by: kOrder, descending: false)
            .getDocuments { (snapshot, error) in  //getDocuments
            guard let snapshot = snapshot else { return }
                
            if !snapshot.isEmpty {
                self.countRow = snapshot.documents.count
                
                for snapshot in snapshot.documents {
                    let dictionaryRows = snapshot.data()
                    returnRows.append(dictionaryRows)
                }
                completion(returnRows)
            } else {
                completion(returnRows)
            }
          }
    }
    
    
    func searchById(objectId: String, whereField: String = "kId", completion: @escaping (_ content:[String : Any]?) -> Void) {
            FirebaseReference(collectionRef)
             .whereField(whereField, isEqualTo: objectId)
            .getDocuments { (snapshot, error) in

           guard let snapshot = snapshot else { return }

           if !snapshot.isEmpty {
                self.countRow = snapshot.documents.count
                for snapshot in snapshot.documents {
                    let rowData = snapshot.data()
                    completion(rowData)
                    return
                }
            }
        }
    }
    
    func insert(objectId: String,dictionaryRowData: [String:Any], completion: @escaping (_ isCompleted: Bool?) -> Void) {
        
        FirebaseReference(collectionRef).document(objectId).setData(dictionaryRowData) {
            error in
            DispatchQueue.main.async {
                if error != nil {
                    print(error?.localizedDescription)
                    completion(false)
                }
                completion(true)
            }
        }
        
    }
    
    func update(objectId: String, someFields: [String: Any], completion : @escaping (_ isUpdated: Bool?) -> Void) {
        
        if someFields.count > 0 {
          FirebaseReference(collectionRef).document(objectId).updateData(someFields)
        }
    }
    
    func delete(objectId: String, completion: @escaping (_ isCompleted:Bool?) -> Void) {
        // Note: - Remove TodoList
        FirebaseReference(collectionRef).document(objectId).delete() { error in
            if let _ = error {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
}

