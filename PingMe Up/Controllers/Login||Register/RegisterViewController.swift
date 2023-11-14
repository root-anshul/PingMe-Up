//
//  RegisterViewController.swift
//  PingMe Up
//
//  Created by anshul on 14/11/23.
//

import UIKit
import FirebaseAuth


class RegisterViewController: UIViewController, UINavigationControllerDelegate {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill.badge.plus")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds=true
        imageView.layer.borderWidth=2
        imageView.layer.borderColor=UIColor.white.cgColor
        return imageView
        
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    private let first_name: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    private let last_name: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
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
    
    
    private let Registerbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds=true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Register"
        view.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        Registerbutton.addTarget(self,
                              action: #selector(Registerbuttontapped),
                              for: .touchUpInside)
        
        email.delegate = self
        password.delegate = self
        
        //Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(first_name)
        scrollView.addSubview(last_name)
        scrollView.addSubview(email)
        scrollView.addSubview(password)
        scrollView.addSubview(Registerbutton)
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapchangepp))
        
       
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapchangepp(){
        presentPhotoActionSheet()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                width: size,
                                height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        
       first_name.frame = CGRect(x: 30,
                             y: imageView.bottom+10,
                             width: scrollView.width-60,
                             height: 52)
        last_name.frame = CGRect(x: 30,
                             y: first_name.bottom+10,
                             width: scrollView.width-60,
                             height: 52)
        email.frame = CGRect(x: 30,
                             y: last_name.bottom+10,
                             width: scrollView.width-60,
                             height: 52)
        password.frame = CGRect(x: 30,
                             y: email.bottom+15,
                             width: scrollView.width-60,
                             height: 52)
        Registerbutton.frame = CGRect(x: 30,
                             y: password.bottom+15,
                             width: scrollView.width-60,
                             height: 52)
        
        
    }
    
    @objc private func Registerbuttontapped(){
        
        email.resignFirstResponder()
        password.resignFirstResponder()
        first_name.resignFirstResponder()
        last_name.resignFirstResponder()
        
        guard let firstname = first_name.text,
              let lastname = last_name.text,
              let email = email.text,
              let password = password.text,
              !firstname.isEmpty,
              !lastname.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count >= 6
        else {
            alertuser()
            return
        }
        // FIREBASE Login
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {authResult, error in
            guard authResult != nil, error == nil else{
                print ("Error cureating user")
                return
            }
            
        })
    }
  
    
    
    func alertuser(message: String = "Please enter all information to create a new account."){
        let alert = UIAlertController(title: "Woops",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true)
    }
    @objc private func didTapRegister(){
        let vc = RegisterViewController()
        vc.title="Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == email{
            password.becomeFirstResponder()
        }
        else if textField == password{
            Registerbuttontapped()
        }
        
        return true
    }
}
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationBarDelegate{
    
    func presentPhotoActionSheet () {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                            self?.presentcamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Chose Photo",
                                            style: .default,
                                            handler: { [weak self]_ in
                                            self?.presentphoto()
            
                        
        }))
        
        present(actionSheet, animated: true)
        
    }
    func presentcamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:true)
    }
    
    func presentphoto(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print(info)

        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        else{
            return
        }
        
        self.imageView.image = selectedImage
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
