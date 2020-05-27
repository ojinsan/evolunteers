//
//  LoginViewController.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 25/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit
import Combine
import CloudKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    let privateDatabase = CKContainer.default().privateCloudDatabase
    let publicDatabase = CKContainer.default().publicCloudDatabase
    let sharedDatabase = CKContainer.default().sharedCloudDatabase
    
    @IBOutlet weak var viewBottom: UIView!{
        didSet{
            viewBottom.layer.cornerRadius = 16
            viewBottom.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    let viewBottomHeight = CGFloat(502)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupProviderLoginView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginStackView.addArrangedSubview(authorizationButton)
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        self.dismissViewBottom()
        self.delay(1) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func dismissViewBottom(){
        self.activityIndicatorView.isHidden = false
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: { [weak self] in
            let frame = self?.viewBottom.frame
            self?.viewBottom.frame = CGRect(x: 0, y: self?.heightScreen ?? 0, width: frame?.width ?? 0, height: frame?.height ?? 0)
            
        }, completion: { [weak self] complete in
            self?.viewBottom.isHidden = true
        })
    }
    
    func showViewBottom(){
        self.activityIndicatorView.isHidden = true
        self.viewBottom.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            let frame = self.viewBottom.frame
            self.viewBottom.frame = CGRect(x: 0, y: self.heightScreen - (self.viewBottomHeight), width: frame.width, height: frame.height - self.viewBottomHeight)
        }, completion: { [weak self] complete in
            self?.viewBottom.isHidden = false
        })
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let _ = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email ?? ""
            
            // save preference
            PreferenceManager.instance.isUserLogin = true
            PreferenceManager.instance.userEmail = email
            PreferenceManager.instance.userName = "\(fullName?.givenName ?? "")"
            
            self.delay(0.5) {
                let predicate = NSPredicate(format: "%K == %@", argumentArray: ["email", "\(email)"])
                Members.query(predicate: predicate, result: { (users) in
                    if let users = users, users.count == 0 {
                        self.saveNewMembers(fullName: fullName?.givenName ?? "", email: email)
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }) { (error) in
                    self.showViewBottom()
                    print(error)
                }
            }
            
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("passwordCredential.username : \(username)")
            print("passwordCredential.password : \(password)")
            
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    func saveNewMembers(fullName: String, email: String) {
        Members(namaLengkap: "\(fullName)", pendidikan: "", jabatan: "", email: "\(email)", alamat: "").save(result: { (result) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }) { (error) in
            self.showViewBottom()
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if self.viewBottom.isHidden == true {
            self.delay(0.5) {
                self.showViewBottom()
            }
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!
    }
}

extension LoginViewController {
    
    /// syntact to check user is login?
//    if PreferenceManager.instance.isUserLogin {
//
//    }
    
    /// syntact to call name user and email
//    PreferenceManager.instance.userName
//    PreferenceManager.instance.userEmail
    
    /// call this func to move login menu
//    func toLogin() {
//        let storyboard = UIStoryboard(name: "Login", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.present(vc, animated: true)
//    }
    
}
