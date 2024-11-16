//
//  BaseVC.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import UIKit
import Foundation

class BaseVC: UIViewController {
    
    @IBOutlet weak var btnSHowTrailer       : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - generic functions
    
    func showAlert(withTitle title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - IBActions
    @IBAction func backPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
