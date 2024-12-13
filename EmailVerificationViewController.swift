//
//  EmailVerificationViewController.swift
//  Sign-In
//
//  Created by Abdul Manan on 11/12/2024.
//

import UIKit

class EmailVerificationViewController: UIViewController {

    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var footerLabel: UILabel!
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        // Style the Resend Button
        resendButton.layer.cornerRadius = 25
        resendButton.backgroundColor = blueC
        resendButton.setTitleColor(.white, for: .normal)

        // Style the Title Label
        

        // Style the Description Label
//        descriptionLabel.textAlignment = .left


        // Style the Footer Label
        footerLabel.textAlignment = .center
        footerLabel.numberOfLines = 0
    }
    
    @IBAction func resendButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let emailVerifiedVC = storyboard.instantiateViewController(withIdentifier: "EmailVerifiedViewController") as? EmailVerifiedViewController {
                emailVerifiedVC.modalPresentationStyle = .fullScreen
                self.present(emailVerifiedVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func backToLogIn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
    }
    }
}
