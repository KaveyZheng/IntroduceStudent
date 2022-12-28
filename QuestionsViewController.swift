//
//  QuestionsViewController.swift
//  IntroduceStudent
//
//  Created by Kavey Zheng on 12/26/22.
//

import UIKit

class QuestionsViewController: UIViewController {
    var first : String = ""
    var last : String = ""
    var school : String = ""
    var introduction : String = ""
    
    @IBOutlet weak var schoolYearSegment: UISegmentedControl!
    @IBOutlet weak var numPets: UILabel!
    @IBOutlet weak var petsStepper: UIStepper!
    @IBOutlet weak var petsSwitch: UISwitch!
    @IBOutlet weak var numSibs: UILabel!
    @IBOutlet weak var sibsStepper: UIStepper!
    @IBOutlet weak var seasonSegment: UISegmentedControl!
    
    @IBOutlet weak var birthdayTextField: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()

        // Do any additional setup after loading the view.
    }
    
    func createToolbar() -> UIToolbar {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didTapDone))
        toolbar.setItems([done], animated: true)
        
        return toolbar
    }
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        birthdayTextField.textAlignment = .center
        birthdayTextField.inputView = datePicker
        birthdayTextField.inputAccessoryView = createToolbar()
    }
    @objc func didTapDone() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .none
        
        self.birthdayTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func petsStepperDidChange(_ sender: UIStepper) {
        numPets.text = "\(Int(sender.value))"
    }
    @IBAction func sibsStepperDidChange(_ sender: UIStepper) {
        numSibs.text = "\(Int(sender.value))"
    }
    @IBAction func didTapIntroduce(_ sender: Any) {
        let year = schoolYearSegment.titleForSegment(at: schoolYearSegment.selectedSegmentIndex)
        let season = seasonSegment.titleForSegment(at: seasonSegment.selectedSegmentIndex)
                
        // String that holds intro, receives values from outlet connections
        introduction = "My name is \(first) \(last) and I was born on \(birthdayTextField.text!). I am in my \(year!) year and attend \(school).\n\nI own \(numPets.text!) pet(s)"
        
        if petsSwitch.isOn { introduction += ". And I want more pets" }
        introduction += "\nI have \(numSibs.text!) siblings\nMy favorite season is \(season!)"
        
        // Create alert for intro
        let alertController = UIAlertController(title: "My Introduction", message: introduction, preferredStyle: .alert)
                
        // A way to dismiss the box once it pops up
        let action = UIAlertAction(title: "Nice to meet you!", style: .default, handler: nil)
                
        // Passing this action to the alert controller so it can be dismissed
        alertController.addAction(action)
                
        present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
