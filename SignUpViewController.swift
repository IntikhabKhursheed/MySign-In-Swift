//
//  SignUpViewController.swift
//  Sign-In
//
//  Created by Abdul Manan on 10/12/2024.
//

import UIKit

class SignUpViewController: UIViewController {
    // Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var middleNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var privacyService: UILabel!
    @IBOutlet weak var SignButton: UIButton!
    
    public let lightGrayBlueColor = UIColor(red: 241/255, green: 247/255, blue: 250/255, alpha: 1.0)
    public let lightyGray = UIColor(red: 139/255.0, green: 147/255.0, blue: 157/255.0, alpha: 1.0)
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        self.navigationItem.hidesBackButton = true
        setupPrivacyServiceLabel()
        emailErrorLabel.isHidden = true // Initially hide the error label
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
        // Customize the UI
        nextButton.layer.cornerRadius = 25
        nextButton.isEnabled = false
        nextButton.backgroundColor = lightGrayBlueColor

        // Add placeholder styling
        setupTextField(firstNameTextField, placeholder: "First Name*")
        setupTextField(middleNameTextField, placeholder: "Middle Name")
        setupTextField(lastNameTextField, placeholder: "Last Name*")
        setupTextField(emailTextField, placeholder: "Email*")

        // Real-time validation
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        SignButton.layer.cornerRadius = 25
        SignButton.layer.borderWidth = 1
        SignButton.layer.borderColor = UIColor.lightGray.cgColor
        
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
        SignButton.setAttributedTitle(attributedString, for: .normal)

        
    }

    private func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.layer.borderColor = lightyGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
    }

    @objc private func textFieldChanged() {
        // Real-time UI updates for email validation
        guard let email = emailTextField.text else { return }

        if isValidEmail(email) {
            // If email is valid, clear error label and reset border
            emailErrorLabel.isHidden = true
            emailTextField.layer.borderColor = lightyGray.cgColor
        } else {
            // If email is invalid, show the error label and red border
            emailErrorLabel.text = "Please enter a valid email address"
            emailErrorLabel.isHidden = false
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailErrorLabel.textColor = UIColor.red
        }

        // Enable Next button (always enabled to allow the alert to trigger)
        let isOtherFieldsValid = !(firstNameTextField.text?.isEmpty ?? true) &&
            !(lastNameTextField.text?.isEmpty ?? true)

        nextButton.isEnabled = isOtherFieldsValid
        nextButton.backgroundColor = isOtherFieldsValid ? blueC : lightGrayBlueColor
        nextButton.titleLabel?.textColor = .white
    }


    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }

        if !isValidEmail(email) {
            // Show alert for invalid email
            showInvalidEmailAlert()
            
            // Also show the error label and red border
            emailErrorLabel.text = "Please enter a correct email address"
            emailErrorLabel.isHidden = false
            emailTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            // Clear error if email is valid
            emailErrorLabel.isHidden = true
            emailTextField.layer.borderColor = lightyGray.cgColor

            // Proceed to the "Create Password" screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
            if let createPasswordVC = storyboard.instantiateViewController(withIdentifier: "CreatePasswordViewController") as? CreatePasswordViewController {
                // Push the CreatePasswordViewController onto the navigation stack
                self.navigationController?.pushViewController(createPasswordVC, animated: true)
            }

        }
    }



    private func showInvalidEmailAlert() {
        let alert = UIAlertController(
            title: "A Short Title Is Best",
            message: "A description should be a short, complete sentence.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Action", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func SignInButton(_ sender: Any) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

//    @IBAction func backButton(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
}
