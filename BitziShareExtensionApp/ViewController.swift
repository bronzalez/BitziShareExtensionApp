//
//  ViewController.swift
//  BitziShareExtensionApp
//
//  Created by BRIAN GONZALEZ on 3/13/19.
//  Copyright © 2019 BRIAN GONZALEZ. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var EmailOnTapped: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.4525158301, blue: 0.07279216942, alpha: 1)
        EmailOnTapped.layer.cornerRadius = EmailOnTapped.frame.size.width/2
    }
    
    
    func sendMail(imageView: UIImageView) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self;
            mail.setCcRecipients(["yyyy@xxx.com"])
            mail.setSubject("Your messagge")
            mail.setMessageBody("Message body", isHTML: false)
            let imageData: NSData = imageView.image!.pngData()! as NSData
            mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
            self.present(mail, animated: true, completion: nil)
        }
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        showMailComposer()
    }
    
    func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else{
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["rl239067@stu.rlas-116.org"])
        composer.setSubject("BitziGramTesting")
        composer.setMessageBody("Hopefully the app is working properly", isHTML: false)
        
//        let imageData: NSData = UIImagePNGRepresentation(UIImage.image)!
//        composer.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
//        self.present(composer, animated: true, completion: nil)
        
        present(composer, animated: true)
    }
    
    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
        controller.dismiss(animated: true)
            return
        }
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to Send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email Sent")
        }
        controller.dismiss(animated: true)
    }
    
    
}
