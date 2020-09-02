//
//  ViewController.swift
//  superInitWhoAmI
//
//  Created by Marcela Auslenter on 02/09/2020.
//  Copyright © 2020 The App Business. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

  @IBOutlet var yourEmailTF: UITextField!

  @IBOutlet var targetEmailTF: UITextField!

  @IBOutlet var characterTF: UITextField!

  let dataBase = Firestore.firestore()

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  @IBAction func sendInfo(_ sender: Any) {
    guard let yourEmail = yourEmailTF.text, let theirEmail = targetEmailTF.text, let character = characterTF.text else {
      return
    }
    addUser(yourEmail: yourEmail, theirEmail: theirEmail, character: character)
   }

  private func addUser(yourEmail: String, theirEmail: String, character: String) {
      var ref: DocumentReference? = nil
      ref = dataBase.collection("users").addDocument(data: [
        "yourEmail": yourEmail.lowercased(),
        "theirEmail": theirEmail.lowercased(),
        "character": character
      ]) { err in
          if let err = err {
              print("Error adding document: \(err)")
          } else {
              print("Document added with ID: \(ref!.documentID)")
          }
      }
  }
}

