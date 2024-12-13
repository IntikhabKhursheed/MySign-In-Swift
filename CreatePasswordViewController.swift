//
//  CreatePasswordViewController.swift
//  Sign-In
//
//  Created by Abdul Manan on 10/12/2024.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    // Outlets for password and confirm password fields
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var passwordToggleButton: UIButton!
    @IBOutlet weak var passwordToggleButton2: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var privacyService: UILabel!
    
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
        setupPrivacyServiceLabel()
        setupUI()
    }
    private func setupPrivacyServiceLabel() {
        let fullText = "By creating an account you agree to our Terms of Service and Privacy Policy."
        let termsText = "Terms of Service"
        let privacyText = "Privacy Policy"

        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: NSRange(location: 0, length: fullText.count))

        if let termsRange = fullText.range(of: termsText) {
            let nsRange = NSRange(termsRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: self.blueC, range: nsRange)
        }

        if let privacyRange = fullText.range(of: privacyText) {
            let nsRange = NSRange(privacyRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: self.blueC, range: nsRange)
        }

        privacyService.attributedText = attributedString
    }
    
    
    private func setupUI() {
        // Style password text fields
        setupTextField(passwordTextField, placeholder: "Password*")
        setupTextField(confirmPasswordTextField, placeholder: "Confirm Password*")
        signInButton.layer.cornerRadius = 25
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor.lightGray.cgColor
        
        // Configure the first eye button
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggleButton.tintColor = .gray
        passwordToggleButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        passwordToggleButton.contentHorizontalAlignment = .center

        // Configure the second eye button
        passwordToggleButton2.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggleButton2.tintColor = .gray
        passwordToggleButton2.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        passwordToggleButton2.contentHorizontalAlignment = .center

        
        // Style "Create Account" button
        createAccountButton.layer.cornerRadius = 25
        createAccountButton.backgroundColor = lightGrayBlueColor
        createAccountButton.setTitleColor(.gray, for: .disabled)
        createAccountButton.isEnabled = false
        
        // Add target for real-time password validation
        passwordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        
        let fullText = "Already have an account? Sign In"
        let boldText = "Sign In"

        // Create a mutable attributed string
        let attributedString = NSMutableAttributedString(string: fullText)

        // Set default attributes for the entire string
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: fullText.count))

        // Apply bold and black color to "Sign In"
        if let boldRange = fullText.range(of: boldText) {
            let nsRange = NSRange(boldRange, in: fullText)
            let boldAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 16), // Bold font
                .foregroundColor: UIColor.black          // Black color
            ]
            attributedString.addAttributes(boldAttributes, range: nsRange)
        }

        // Assign the attributed text to the button
        signInButton.setAttributedTitle(attributedString, for: .normal)

    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
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
        
        createAccountButton.isEnabled = isPasswordValid && isPasswordsMatch

        if createAccountButton.isEnabled {
            createAccountButton.backgroundColor = blueC
            let attributedTitle = NSAttributedString(
                string: "Create Account",
                attributes: [.foregroundColor: UIColor.white]
            )
            createAccountButton.setAttributedTitle(attributedTitle, for: .normal)
        } else {
            createAccountButton.backgroundColor = lightGrayBlueColor
            let attributedTitle = NSAttributedString(
                string: "Create Account",
                attributes: [.foregroundColor: UIColor.gray]
            )
            createAccountButton.setAttributedTitle(attributedTitle, for: .normal)
        }

    }
    
    @IBAction func passwordToggle1(_ sender: UIButton) {
        // Toggle the visibility of the password text field
        passwordTextField.isSecureTextEntry.toggle()

        // Update the eye icon to "eye" or "eye.slash" and ensure color remains light gray
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
        passwordToggleButton.tintColor = .gray
    }

    
    @IBAction func passwordToggle2(_ sender: UIButton) {
        // Toggle the visibility of the confirm password text field
        confirmPasswordTextField.isSecureTextEntry.toggle()

        // Update the eye icon to "eye" or "eye.slash" and ensure color remains light gray
        let imageName = confirmPasswordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggleButton2.setImage(UIImage(systemName: imageName), for: .normal)
        passwordToggleButton2.tintColor = .gray
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        showThreeDotLoadingView(withMessage: "Creating account...")

        // Simulate a delay (e.g., API call)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.hideThreeDotLoadingView()
            
            // Navigate to Email Verification View
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let emailVerificationVC = storyboard.instantiateViewController(withIdentifier: "EmailVerificationViewController") as? EmailVerificationViewController {
                emailVerificationVC.modalPresentationStyle = .fullScreen
                self.present(emailVerificationVC, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func BackTapped(_ sender: Any) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func SignInTapped(_ sender: Any) {
        // Assuming your ViewController has the identifier "ViewController"
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
        if let signInVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            signInVC.modalPresentationStyle = .fullScreen // Optional: Adjust presentation style if needed
            self.present(signInVC, animated: true, completion: nil)
        }
    }
}
