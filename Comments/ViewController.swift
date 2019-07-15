//
//  ViewController.swift
//  Comments
//
//  Created by Horbach on 6/23/19.
//  Copyright © 2019 Horbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    

    @IBOutlet weak var labelTop: UILabel!
    
    @IBOutlet weak var labelLow: UILabel!
    
    @IBOutlet weak var labelWarning: UILabel!
    
    @IBOutlet weak var txtFieldTop: UITextField!
    
    @IBOutlet weak var txtFieldLow: UITextField!
    
    @IBOutlet weak var labelButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFieldTop.delegate = self
        self.txtFieldLow.delegate = self
        
        labelButton.isHidden = false
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        self.hideKeyboard()
        setupButtonGet()
        // Do any additional setup after loading the view.
    }
    
    // MARK: TextField info
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFieldTop {
            labelWarning.text = "Enter a number more than 10 from the previous one"
        } else if textField == txtFieldLow {
            labelWarning.text = "Enter the bottom of the array"
        } else {
         return true
            }
         return true
    }
 
    @IBAction func buttonGet(_ sender: Any) {
            filterOfnumber()
    }
    
    
      // MARK: Data for ViewControllerTable
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let distinationVC: ViewControllerTable = segue.destination as! ViewControllerTable
        distinationVC.textofFieldLow = Int(txtFieldLow.text!)
        distinationVC.textofFieldTop = Int(txtFieldTop.text!)
    }
    func filterOfnumber() {
        if txtFieldLow.text!.isEmpty  || txtFieldTop.text!.isEmpty {
            labelWarning.text = "Please enter low and top number"
            labelButton.backgroundColor = .darkGray
            return
        }

            let low: Int = Int(txtFieldLow.text!)!
            let top: Int = Int(txtFieldTop.text!)!
        
        if ((500 >= low) && (low > 0)) && ((500 >= top) && (top > low)){
             labelButton.backgroundColor = .blue
              performSegue(withIdentifier: "tableShow", sender: nil)
        }else {
           // labelButton.isHidden = true
            labelButton.backgroundColor = .darkGray
            labelWarning.text = "Please try again!"
        }
    }
    private func setupButtonGet() {
        labelButton.layer.cornerRadius = 5
        labelButton.layer.borderWidth = 0.1
        labelButton.clipsToBounds = true
    }

}
    // MARK: Hide Keyboard
extension UIViewController {
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
