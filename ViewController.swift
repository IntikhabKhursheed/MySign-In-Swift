//
//  ViewController.swift
//  Sign-In
//
//  Created by Abdul Manan on 10/12/2024.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var togglePasswordButton: UIButton!

    // MARK: - Variables
    private var loadingView: UIView?
    public let lightGrayBlueColor = UIColor(red: 241/255, green: 247/255, blue: 250/255, alpha: 1.0)
    public let lightyGray = UIColor(red: 139/255.0, green: 147/255.0, blue: 157/255.0, alpha: 1.0)


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Add real-time validation observers for email and password fields
        emailTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
    }

    // MARK: - UI Setup
    func setupUI() {
        // Title Label Setup
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        titleLabel.numberOfLines = 2
        titleLabel.text = "Sign in to your\nAccount"
        
        subtitleLabel.textColor = lightyGray

        // Email TextField Setup
        setupTextField(emailTextField)
        emailErrorLabel.text = ""
        emailErrorLabel.textColor = .red
        emailErrorLabel.font = UIFont.systemFont(ofSize: 12)

        // Password TextField Setup
        setupTextField(passwordTextField)
        passwordTextField.isSecureTextEntry = true
        passwordErrorLabel.text = ""
        passwordErrorLabel.textColor = .red
        passwordErrorLabel.font = UIFont.systemFont(ofSize: 12)

        // Password Visibility Toggle Button Setup
        setupPasswordToggleButton()

        // Sign-In Button Setup
        signInButton.backgroundColor = lightGrayBlueColor
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.layer.cornerRadius = 25
        signInButton.isEnabled = false // Initially disabled

        // Register Button Setup
        let fullText = "Need an account? Register Now"
        let boldText = "Register Now"
        let attributedString = NSMutableAttributedString(string: fullText)

        if let boldRange = fullText.range(of: boldText) {
            let nsRange = NSRange(boldRange, in: fullText)
            let boldAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor.black
            ]
            attributedString.addAttributes(boldAttributes, range: nsRange)
        }

        registerButton.setAttributedTitle(attributedString, for: .normal)
        registerButton.layer.cornerRadius = 25
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.gray.cgColor
    }

    func setupTextField(_ textField: UITextField) {
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.setLeftPadding(12)
    }

    func setupPasswordToggleButton() {
        togglePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        togglePasswordButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        togglePasswordButton.tintColor = .gray
    }

    // MARK: - Actions
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let buttonImage = passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        sender.setImage(buttonImage, for: .normal)
    }
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
            if let resetPasswordVC = storyboard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as? ResetPasswordViewController {
                resetPasswordVC.modalPresentationStyle = .fullScreen // Optional: Change presentation style
                present(resetPasswordVC, animated: true, completion: nil)
            }
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        if validateFields() {
            showThreeDotLoadingView(withMessage: "Please wait, Loading...")

               // Simulate a delay (e.g., API call)
               DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                   // Hide the loading view after the delay
                   self.hideThreeDotLoadingView()

                   // Proceed with account creation logic here
                   print("Account created successfully!")
               }
        }
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
        if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            signUpVC.modalPresentationStyle = .fullScreen
            present(signUpVC, animated: true, completion: nil)
        }
    }



    // MARK: - Real-Time Validation
    @objc func textFieldsChanged() {
        let isEmailValid = isValidEmail(emailTextField.text ?? "")
        let isPasswordValid = !(passwordTextField.text?.isEmpty ?? true)

        // Update email error label
        if isEmailValid {
            emailErrorLabel.text = ""
            emailTextField.layer.borderColor = UIColor.gray.cgColor
        } else {
            emailErrorLabel.text = "Enter valid email address"
            emailTextField.layer.borderColor = UIColor.red.cgColor
        }

        // Update password error label
        if isPasswordValid {
            passwordErrorLabel.text = ""
            passwordTextField.layer.borderColor = UIColor.gray.cgColor
        } else {
            passwordErrorLabel.text = "Password is required"
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        }

        // Enable or disable Sign-In button
        if isEmailValid && isPasswordValid {
            signInButton.isEnabled = true
            signInButton.backgroundColor = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
            let title = "Sign In"
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 16)
            ]
            let attributedTitle = NSAttributedString(string: title, attributes: attributes)
            signInButton.setAttributedTitle(attributedTitle, for: .normal)
        } else {
            signInButton.isEnabled = false
        }
    }

    // MARK: - Validation
    func validateFields() -> Bool {
        var isValid = true

        if let email = emailTextField.text, !isValidEmail(email) {
            emailErrorLabel.text = "Enter valid email address"
            emailTextField.layer.borderColor = UIColor.red.cgColor
            isValid = false
        }

        if let password = passwordTextField.text, password.isEmpty {
            passwordErrorLabel.text = "Password is required"
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            isValid = false
        }

        return isValid
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

extension UIViewController {
    func showThreeDotLoadingView(withMessage message: String) {
        // Create a dimmed background view
        let loadingView = UIView(frame: self.view.bounds)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        loadingView.tag = 999 // Tag for easy removal

        // Create a container view for the dots
        let dotsContainer = UIView()
        dotsContainer.translatesAutoresizingMaskIntoConstraints = false
        dotsContainer.backgroundColor = UIColor(red: 82/255, green: 189/255, blue: 236/255, alpha: 1.0) // RGBA color
        dotsContainer.layer.cornerRadius = 28 // Rounded corners for the container
        dotsContainer.layer.masksToBounds = true
        loadingView.addSubview(dotsContainer)

        // Create three dots
        let dotSize: CGFloat = 10
        let dotSpacing: CGFloat = 12
        let numberOfDots = 3
        var dots: [UIView] = []

        for i in 0..<numberOfDots {
            let dot = UIView()
            dot.backgroundColor = .white
            dot.layer.cornerRadius = dotSize / 2
            dot.translatesAutoresizingMaskIntoConstraints = false
            dotsContainer.addSubview(dot)
            dots.append(dot)

            // Position the dots horizontally
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: dotSize),
                dot.heightAnchor.constraint(equalToConstant: dotSize),
                dot.centerYAnchor.constraint(equalTo: dotsContainer.centerYAnchor),
                dot.leadingAnchor.constraint(equalTo: dotsContainer.leadingAnchor, constant: CGFloat(i) * (dotSize + dotSpacing) + 14) // Adjust to center inside the container
            ])
        }

        // Set the width and height of the container
        NSLayoutConstraint.activate([
            dotsContainer.widthAnchor.constraint(equalToConstant: 78),
            dotsContainer.heightAnchor.constraint(equalToConstant: 56),
            dotsContainer.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            dotsContainer.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor, constant: -10)
        ])

        // Add the label below the dots container
        let loadingLabel = UILabel()
        loadingLabel.text = message
        loadingLabel.textColor = .white
        loadingLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        loadingLabel.textAlignment = .center
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(loadingLabel)

        NSLayoutConstraint.activate([
            loadingLabel.topAnchor.constraint(equalTo: dotsContainer.bottomAnchor, constant: 20),
            loadingLabel.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor)
        ])

        // Add the loading view to the current view controller
        self.view.addSubview(loadingView)

        // Add the animation for the dots
        addThreeDotAnimation(to: dots)
    }

    func addThreeDotAnimation(to dots: [UIView]) {
        for (index, dot) in dots.enumerated() {
            let animation = CAKeyframeAnimation(keyPath: "opacity")
            animation.values = [0.3, 1.0, 0.3] // Fading effect
            animation.keyTimes = [0, 0.5, 1]
            animation.duration = 1.0
            animation.beginTime = CACurrentMediaTime() + (Double(index) * 0.2) // Stagger the animations
            animation.repeatCount = .infinity
            dot.layer.add(animation, forKey: "opacityAnimation")
        }
    }

    func hideThreeDotLoadingView() {
        // Find and remove the loading view
        self.view.viewWithTag(999)?.removeFromSuperview()
    }
}


// MARK: - UITextField Padding Extension
extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


