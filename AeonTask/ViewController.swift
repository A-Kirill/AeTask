//
//  ViewController.swift
//  AeonTask
//
//  Created by Kirill Anisimov on 22.02.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var signInView: SignInView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldsDelegate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        signInView.loginInputView.textField.text = ""
        signInView.passwordInputView.textField.text = ""
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        
        guard let login = signInView.loginInputView.textField.text,
              let password = signInView.passwordInputView.textField.text
        else { return }
        
        signInView.activityIndicator.startAnimating()
        
        let service = AeonService()
        
        service.signIn(login: login, password: password) { response in

            self.signInView.activityIndicator.stopAnimating()

            if response.success == "true" {
                UserDefaults.standard.set(true, forKey: "isLogin")
                UserDefaults.standard.setValue(response.response?.token, forKey: "token")
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let transactionVC = storyboard.instantiateViewController(withIdentifier: "TransactionsViewController") as! TransactionsViewController

                self.navigationController?.pushViewController(transactionVC, animated: true)
            } else {
                let alert = UIAlertController(title: "Ошибка", message: response.error?.errorMsg, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    func setupTextFieldsDelegate() {
        signInView.passwordInputView.textField.delegate = self
        signInView.loginInputView.textField.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case signInView.loginInputView.textField:
            signInView.passwordInputView.textField.becomeFirstResponder()
        default:
            signInView.passwordInputView.textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == signInView.loginInputView.textField && string.last == " " {
            return false
        }
        return true
    }

}
