//
//  PasswordResetVerificationViewController.swift
//  Sign-In
//
//  Created by Abdul Manan on 12/12/2024.
//

import UIKit

class PasswordResetVerificationViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!

    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    
    var userEmail: String = "" // Dynamically set by ResetPasswordViewController

    override func viewDidLoad() {
//        self.navigationItem.hidesBackButton = true
        super.viewDidLoad()

        // Dynamically set the description label
        setDescriptionLabel()
        setupUI()
    }
    
   private func setupUI(){
       resendButton.layer.backgroundColor = blueC.cgColor
        resendButton.titleLabel?.textColor = UIColor.white
       resendButton.layer.cornerRadius = 25
    }

    private func setDescriptionLabel() {
        let fullText = "An activation link has been sent to '\(userEmail)'. Check your inbox and click the link to verify your account before you continue using this app."
        let boldText = "'\(userEmail)'"

        let attributedString = NSMutableAttributedString(string: fullText)

        // Apply bold formatting to the email part
        if let boldRange = fullText.range(of: boldText) {
            let nsRange = NSRange(boldRange, in: fullText)
            attributedString.addAttributes([
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor.black
            ], range: nsRange)
        }

        descriptionLabel.attributedText = attributedString
    }

    @IBAction func backToLoginPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            // Push the ViewController onto the navigation stack
            self.navigationController?.pushViewController(loginVC, animated: true)
        }

    }

    @IBAction func resendEmail(_ sender: Any) {
        if let setPasswordVC = storyboard?.instantiateViewController(withIdentifier: "SetPasswordViewController") as? SetPasswordViewController {
            // Push the SetPasswordViewController onto the navigation stack
            self.navigationController?.pushViewController(setPasswordVC, animated: true)
        } else {
            print("Error: Unable to instantiate SetPasswordViewController")
        }

    }

}
