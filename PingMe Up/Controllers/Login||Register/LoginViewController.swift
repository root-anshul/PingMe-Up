//
//  LoginViewController.swift
//  PingMe Up
//
//  Created by anshul on 14/11/23.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Loginlogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    private let email: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let password: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds=true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    private let googleLogin = GIDSignInButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Log In"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done                                              , target: self
                      ,action: #selector(dididtapRegister))
        
        loginbutton.addTarget(self,
                              action: #selector(loginbuttontapped),
                              for: .touchUpInside)
        email.delegate = self
        password.delegate = self
        
        
    //Add Subview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(email)
        scrollView.addSubview(password)
        scrollView.addSubview(loginbutton)
        scrollView.addSubview(googleLogin)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                width: size,
                                height: size)
        email.frame = CGRect(x: 30,
                             y: imageView.bottom+10,
                             width: scrollView.width-60,
                             height: 52)
        password.frame = CGRect(x: 30,
                             y: email.bottom+10,
                             width: scrollView.width-60,
                             height: 52)
        loginbutton.frame = CGRect(x: 30,
                             y: password.bottom+10,
                             width: scrollView.width-60,
                             height: 52)
        googleLogin.frame = CGRect(x: 30,
                             y: loginbutton.bottom+10,
                             width: scrollView.width-60,
                             height: 52)
    }
    @objc private func loginbuttontapped(){
        email.resignFirstResponder()
        password.resignFirstResponder()
        guard let email = email.text, let password = password.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertuser()
            return
        }
        // FIREBASE Login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self] authResult, error in
            guard let strongSelf = self else{
                return
            }
            guard let result = authResult, error == nil else{
                print ("Failed to log in user with email: \(email)")
                return
            }
            let user=result.user
            print("Logged in user\(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            
        })
        
    }
    func alertuser(){
        let alert = UIAlertController(title: "Woops", message: "Please enter valid information to login", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    @objc private func dididtapRegister(){
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == email{
            password.becomeFirstResponder()
        }
        else if textField == password{
            loginbuttontapped()
        }
        
        return true
    }
}

