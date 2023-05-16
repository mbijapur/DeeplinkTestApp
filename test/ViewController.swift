//
//  ViewController.swift
//  test
//
//  Created by Maheshashok Bijapur on 15/05/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .darkGray
    }

    @IBAction func associateLeadAction(_ sender: UIButton) {
        
        let marketo = Marketo.sharedInstance()
        let profile =  MarketoLead()
         
        // Get user profile from network and populate
        profile?.setEmail("may15-2@adobe.com")
        profile?.setFirstName("Mahesh")
        profile?.setLastName("B")
        profile?.setCity("Bengaluru")
        marketo?.associateLead(profile)
        
    }
    
    
    
    
    @IBAction func customActionClicked(_ sender: UIButton) {
        print("custom action")
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        Marketo.sharedInstance().unregisterPushDeviceToken()
        print("logout action")
    }
}

