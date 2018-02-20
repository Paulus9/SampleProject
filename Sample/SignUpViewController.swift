//
//  SignUpViewController.swift
//  Sample
//
//  Created by SysBig on 18/10/17.
//  Copyright © 2017 SysBig. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerData = ["+91","+11","+1"]
        pickerView.layer.cornerRadius = 1.5
        pickerView.layer.borderColor = UIColor.gray.cgColor
        pickerView.layer.borderWidth = 1.0
        pickerView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SignUpViewController : UIPickerViewDataSource,UIPickerViewDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        codeTextField.text = pickerData[row]
        pickerView.isHidden = true
        mobileNumberTextField.becomeFirstResponder()
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let label = (view as? UILabel) ?? UILabel()
        guard (view as? UILabel) != nil else
        {
            label.textColor = .black
            label.textAlignment = .left
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.text = pickerData[row]
            return label
        }
        return label
    }
}
extension SignUpViewController :  UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        pickerView.isHidden = false
    }
}
