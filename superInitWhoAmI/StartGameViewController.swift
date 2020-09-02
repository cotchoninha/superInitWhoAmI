//
//  StartGameViewController.swift
//  superInitWhoAmI
//
//  Created by Marcela Auslenter on 02/09/2020.
//  Copyright © 2020 The App Business. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

struct User: Codable {
  let yourEmail: String
  let theirEmail: String
  let character: String
}

final class StartGameViewController: UIViewController {

  @IBOutlet var yourEmailTF: UITextField!

  @IBOutlet var listOFWhoAmI: UILabel!

  let dataBase = Firestore.firestore()
  
  @IBAction func starGame(_ sender: Any) {
    guard let yourEmail = yourEmailTF.text else { return }
    dataBase.collection("users").getDocuments() { (querySnapshot, err) in
      guard let querySnapshot = querySnapshot else { return }
      for documents in querySnapshot.documents {
        let result = Result {
          try documents.data(as: User.self)
        }
        switch result {
        case .success(let user):
          if let user = user {
            print("User: \(user)")
            if user.yourEmail != yourEmail {
              self.listOFWhoAmI.text?.append("\(user.theirEmail) is \(user.character)\n")
            }
          } else {

            print("Document does not exist")
          }
        case .failure(let error):
          print("Error decoding city: \(error)")
        }
      }
    }
  }
}
