//
//  ResetPasswordViewController.swift
//  Sign-In
//
//  Created by Abdul Manan on 12/12/2024.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordRecoverButton: UIButton!
    
    public let lightGrayBlueColor = UIColor(red: 241/255, green: 247/255, blue: 250/255, alpha: 1.0)
    public let lightyGray = UIColor(red: 139/255.0, green: 147/255.0, blue: 157/255.0, alpha: 1.0)
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true

        // Initial Setup
        setupUI()

        // Add target for real-time email validation
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }

    private func setupUI() {
        // Initially disable the button
        passwordRecoverButton.isEnabled = false
        passwordRecoverButton.backgroundColor = lightGrayBlueColor // Disabled state
        passwordRecoverButton.setTitleColor(.darkGray, for: .normal)
        passwordRecoverButton.layer.cornerRadius = 25
        
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 5
        
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
    }

    // Real-time validation method
    @objc private func textFieldChanged() {
        guard let email = emailTextField.text else { return }

        // Validate email
        let isEmailValid = isValidEmail(email)

        // Enable or disable button based on validation
        passwordRecoverButton.isEnabled = isEmailValid
        passwordRecoverButton.backgroundColor = isEmailValid ? blueC : lightGrayBlueColor
        passwordRecoverButton.setTitleColor(isEmailValid ? .white : .gray, for: .normal)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    // Actions
    @IBAction func passwordRecoverTapped(_ sender: Any) {
        guard let email = emailTextField.text, isValidEmail(email) else {
            // Show an alert if email is invalid
            let alert = UIAlertController(title: "Invalid Email", message: "Please enter a valid email address.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        // Navigate to PasswordResetVerificationViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let verificationVC = storyboard.instantiateViewController(withIdentifier: "PasswordResetVerificationViewController") as? PasswordResetVerificationViewController {
            // Dynamically set the user's email
            verificationVC.userEmail = email
            // Push the PasswordResetVerificationViewController onto the navigation stack
            self.navigationController?.pushViewController(verificationVC, animated: true)
        }

    }

//    @IBAction func backToPrevious(_ sender: Any) {
//        // Handle navigation to the previous screen
//        dismiss(animated: true, completion: nil)
//    }
}

