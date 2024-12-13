//
//  EmailVerifiedViewController.swift
//  Sign-In
//
//  Created by Abdul Manan on 12/12/2024.
//

import UIKit

class EmailVerifiedViewController: UIViewController {
    
    
    @IBOutlet weak var continueToLoginButton: UIButton!
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI(){
        continueToLoginButton.layer.cornerRadius = 25
        continueToLoginButton.backgroundColor = blueC
        

    }
    @IBAction func continueToLoginTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
    
    }
}
