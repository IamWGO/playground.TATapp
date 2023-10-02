//
//  FCollectionReference.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-06-20.
//

import Foundation
import Firebase

enum FCollectionReference: String {
    case User = "Users"
    case Place = "Place"
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
