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


class SignInVC: UIViewController {
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to authenticate with Facebook - \(error)")
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
                print("Unable to authenticate with Firebase -\(error)")
            }else{
                print("Successfully authenticate with Firebase")
            }
        }
    }
    @IBAction func signInBtnPressed(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text{
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil{
                    print("Email user authenticate with Firebase")
                }else{
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil{
                            print ("Unable to authenticate with firebase using email -\(error)")
                        }else{
                            print("Successfully authenticate with Firebase")
                        }
                    })
                }
            })
        }
    }


}

