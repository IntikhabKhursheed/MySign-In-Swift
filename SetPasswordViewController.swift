//
//  SetPasswordViewController.swift
//  Sign-In
//
//  Created by Abdul Manan on 12/12/2024.
//

import UIKit

class SetPasswordViewController: UIViewController {
    // Outlets for password and confirm password fields
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var setPasswordButton: UIButton!
    @IBOutlet weak var passwordToggleButton: UIButton!
    @IBOutlet weak var passwordToggleButton2: UIButton!
    
    // Outlets for Password validation
    @IBOutlet weak var characters: UILabel!
    @IBOutlet weak var cases: UILabel!
    @IBOutlet weak var numbers: UILabel!
    @IBOutlet weak var specialCharacter: UILabel!
    
    public let lightGrayBlueColor = UIColor(red: 241/255, green: 247/255, blue: 250/255, alpha: 1.0)
    public let greenColor = UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1.0)
    public let grayColor = UIColor.lightGray
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
    
    private func setupUI() {
        
        // Configure the first eye button
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggleButton.tintColor = .gray
        passwordToggleButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        passwordToggleButton.contentHorizontalAlignment = .center

        //Password text field setup
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.layer.borderColor = grayColor.cgColor
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        
        // Confirm password field setup
        confirmPasswordTextField.layer.borderWidth = 1
        confirmPasswordTextField.layer.cornerRadius = 8
        confirmPasswordTextField.layer.borderColor = grayColor.cgColor
        confirmPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: confirmPasswordTextField.frame.height))
        confirmPasswordTextField.leftViewMode = .always
        
        
        // Configure the second eye button
        passwordToggleButton2.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggleButton2.tintColor = .gray
        passwordToggleButton2.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        passwordToggleButton2.contentHorizontalAlignment = .center

        
        // Style "Create Account" button
        setPasswordButton.layer.cornerRadius = 25
        setPasswordButton.backgroundColor = lightGrayBlueColor
        setPasswordButton.setTitleColor(.gray, for: .disabled)
        setPasswordButton.isEnabled = false
        
        // Add target for real-time password validation
        passwordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)

    }

    
    @objc private func validatePassword() {
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        // Check each validation rule
        let isCharactersValid = password.count >= 10
        let isCaseValid = password.range(of: "[A-Z]", options: .regularExpression) != nil &&
                          password.range(of: "[a-z]", options: .regularExpression) != nil
        let isNumberValid = password.range(of: "\\d", options: .regularExpression) != nil
        let isSpecialCharacterValid = password.range(of: "[^a-zA-Z0-9]", options: .regularExpression) != nil
        
        // Update label colors
        characters.textColor = isCharactersValid ? greenColor : grayColor
        cases.textColor = isCaseValid ? greenColor : grayColor
        numbers.textColor = isNumberValid ? greenColor : grayColor
        specialCharacter.textColor = isSpecialCharacterValid ? greenColor : grayColor
        
        // Enable or disable the "Create Account" button
        let isPasswordValid = isCharactersValid && isCaseValid && isNumberValid && isSpecialCharacterValid
        let isPasswordsMatch = password == confirmPassword && !confirmPassword.isEmpty
        
        setPasswordButton.isEnabled = isPasswordValid && isPasswordsMatch

        if setPasswordButton.isEnabled {
            setPasswordButton.backgroundColor = blueC
            let attributedTitle = NSAttributedString(
                string: "Create Account",
                attributes: [.foregroundColor: UIColor.white]
            )
            setPasswordButton.setAttributedTitle(attributedTitle, for: .normal)
        } else {
            setPasswordButton.backgroundColor = lightGrayBlueColor
            let attributedTitle = NSAttributedString(
                string: "Create Account",
                attributes: [.foregroundColor: UIColor.gray]
            )
            setPasswordButton.setAttributedTitle(attributedTitle, for: .normal)
        }

    }
    
    @IBAction func passwordToggle1(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
        passwordToggleButton.tintColor = .gray
    }

    @IBAction func passwordToggle2(_ sender: UIButton) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        let imageName = confirmPasswordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggleButton2.setImage(UIImage(systemName: imageName), for: .normal)
        passwordToggleButton2.tintColor = .gray
    }

    
    @IBAction func setPassword(_ sender: UIButton) {

    }
    
    @IBAction func BackTapped(_ sender: Any) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

}
