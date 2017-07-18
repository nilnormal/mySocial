//
//  ViewController.swift
//  devslopes-social
//
//  Created by xannas on 7/17/2560 BE.
//  Copyright © 2560 xannas. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            print("ID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to authenticate with Facebook - \(error.debugDescription)")
            }else if result?.isCancelled == true{
                print("User cancelled Facebook authenticate")
            }else{
                print("Successfully authenticate with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential: credential)
            }
        }
    }
    func firebaseAuth(credential: AuthCredential){
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil{
                print("Unable to authenticate with Firebase -\(error.debugDescription)")
            }else{
                print("Successfully authenticate with Firebase")
                if let user = user{
                    self.completeSignIn(id: user.uid)                }
            }
        }
    }
    @IBAction func signInBtnPressed(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text{
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil{
                    print("Email user authenticate with Firebase")
                    if let user = user{
                        self.completeSignIn(id: user.uid)
                    }
                }else{
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil{
                            print ("Unable to authenticate with firebase using email -\(error.debugDescription)")
                        }else{
                            print("Successfully authenticate with Firebase")
                            if let user = user{
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
    }

    func completeSignIn(id: String){
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Data save to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    

}

