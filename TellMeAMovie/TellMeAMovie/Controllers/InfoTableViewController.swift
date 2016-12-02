//
//  InfoTableViewController.swift
//  TellMeAMovie
//
//  Created by Илья on 02.12.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit
import MessageUI

class InfoTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func writeLetter(_ sender: UIButton) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["ilyagutnikov93@gmail.com"])
        mailComposerVC.setSubject("TellMeAMovie in-app e-mail")
        mailComposerVC.setMessageBody("Сообщение отправлено из приложения TellMeAMovie", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Невозможно отправить сообщение", message: "Ваше устройство не может отправить e-mail. Пожалуйста, измените конфигурацию и попробуйте снова.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismiss(animated: true, completion: nil)
        
    }


}
