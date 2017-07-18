//
//  FeedVC.swift
//  devslopes-social
//
//  Created by xannas on 7/18/2560 BE.
//  Copyright © 2560 xannas. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func signOutBtnPressed(_ sender: UIButton) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ID remove from keychain -\(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }

    

   
}
