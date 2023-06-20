//
//  FCollectionReference.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-06-20.
//

import Foundation
import Firebase

enum FCollectionReference: String {
    case User = "pia_user"
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
