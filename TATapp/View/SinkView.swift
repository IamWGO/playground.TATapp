//
//  SinkView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-05-23.
//

import SwiftUI

struct Users: Codable {
    let username: String
    let email: String
    
    
    static func structureToDictionary(row: Self) -> [String : Any] {
        
        return NSDictionary(
            objects:
                [row.username,
                 row.email
                ],
            forKeys: [
                 "username" as NSCopying,
                  "email" as NSCopying,
            ]
        ) as! [String : Any]
    }
    
    
    init(
        _username: String,
        _email: String
    ) {
        username = _username
        email = _email
    }
    
    static func dictionaryToStructrue(_ row: [String : Any]) -> Self{
        return Self(_username: row["username"] as? String ?? "",
             _email: row["email"] as? String ?? ""
             )
    }
}

struct SinkView: View {
    @EnvironmentObject var mainVM: MainViewModel
    let collectionRef: FCollectionReference = .User
    let username = "Lee"
    let email = "waleerat.gottlieb@gmail.com"
    
    
    var body: some View {
        VStack {
            Text("page")
              
            Button {
                
                let user = ["username" : username,
                            "email" : email]
                let id = email
                
                let dictionary = Users.structureToDictionary(row: Users.dictionaryToStructrue(user))
                
                FirebaseManager<Users>(fCollection: collectionRef).insert(objectId: id, dictionaryRowData: dictionary, completion: { isCompleted in
                    print("Added")
                })
                
                //
            } label: {
                Text("Add Record")
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.blue)
            }

        }
        
    }
}



/*
 
 struct Users: Codable {
     let username: String
     let email: String
     
     
     static func structureToDictionary(row: Self) -> [String : Any] {
         
         return NSDictionary(
             objects:
                 [row.username,
                  row.email
                 ],
             forKeys: [
                  "username" as NSCopying,
                   "email" as NSCopying,
             ]
         ) as! [String : Any]
     }
     
     
     init(
         _username: String,
         _email: String
     ) {
         username = _username
         email = _email
     }
     
     static func dictionaryToStructrue(_ row: [String : Any]) -> Self{
         return Self(_username: row["username"] as? String ?? "",
              _email: row["email"] as? String ?? ""
              )
     }
 }

 struct SinkView: View {
     @EnvironmentObject var mainVM: MainViewModel
     let collectionRef: FCollectionReference = .User
     let username = "Lee"
     let email = "waleerat.gottlieb@gmail.com"
     
     
     var body: some View {
         VStack {
             Text("page")
               
             Button {
                 
                 let user = ["username" : username,
                             "email" : email]
                 let id = email
                 
                 let dictionary = Users.structureToDictionary(row: Users.dictionaryToStructrue(user))
                 
                 FirebaseManager<Users>(fCollection: collectionRef).insert(objectId: id, dictionaryRowData: dictionary, completion: { isCompleted in
                     print("Added")
                 })
                 
                 //
             } label: {
                 Text("Add Record")
                     .padding()
                     .foregroundColor(Color.white)
                     .background(Color.blue)
             }

         }
         
     }
 }

 
 */
