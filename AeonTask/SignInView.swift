//
//  SignInView.swift
//  AeonTask
//
//  Created by Kirill Anisimov on 22.02.2021.
//

import UIKit

class SignInView: UIView {

    @IBOutlet weak var loginInputView: CustomInputTextView!
    @IBOutlet weak var passwordInputView: CustomInputTextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loginInputView.setup(headerText: "Логин")
        passwordInputView.setup(headerText: "Пароль")
        passwordInputView.textField.isSecureTextEntry = true
        
        loginInputView.textField.returnKeyType = .next
        passwordInputView.textField.returnKeyType = .done
        loginInputView.textField.autocorrectionType = .no
        
        activityIndicator.hidesWhenStopped = true
    }
    
}
