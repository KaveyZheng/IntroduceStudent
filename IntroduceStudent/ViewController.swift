//
//  ViewController.swift
//  IntroduceStudent
//
//  Created by Kavey Zheng on 12/26/22.
//
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var questionsController: ViewController!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var lastTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    let userDefaults = UserDefaults()
    
    var imageViews = [UIImageView]()
    @IBOutlet weak var MIT: UIImageView!
    @IBOutlet weak var UCLA: UIImageView!
    @IBOutlet weak var UMich: UIImageView!
    @IBOutlet weak var Cornell: UIImageView!
    @IBOutlet weak var Bing: UIImageView!
    @IBOutlet weak var NYU: UIImageView!
    @IBOutlet weak var Fordham: UIImageView!
    @IBOutlet weak var STJ: UIImageView!
    @IBOutlet weak var Princeton: UIImageView!
    @IBOutlet weak var Syracuse: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    let colors: [UIColor] = [ // array of different colors
        .systemYellow,
        .systemRed,
        .systemBrown,
        .systemGray,
        .systemGreen,
        .systemPurple,
    ]
    
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.updateSchools()
        })
        imageViews.append(MIT)
        imageViews.append(UCLA)
        imageViews.append(UMich)
        imageViews.append(Cornell)
        imageViews.append(Bing)
        imageViews.append(NYU)
        imageViews.append(Fordham)
        imageViews.append(STJ)
        imageViews.append(Princeton)
        imageViews.append(Syracuse)
        for image in imageViews { image.isHidden = true }
        
        firstTextField.delegate = self
        lastTextField.delegate = self
        schoolTextField.delegate = self
        if let value = userDefaults.value(forKey: "first") as? String {
            firstTextField.text = value
        }
        if let value = userDefaults.value(forKey: "last") as? String {
            lastTextField.text = value
        }
        if let value = userDefaults.value(forKey: "school") as? String {
            schoolTextField.text = value
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userDefaults.setValue(firstTextField.text, forKey: "first")
        userDefaults.setValue(lastTextField.text, forKey: "last")
        userDefaults.setValue(schoolTextField.text, forKey: "school")
        print("Saved")
        return true
    }
    
    var prev = 0
    func updateSchools() {
        imageViews[prev].isHidden = true
        var randInt = Int.random(in: 0...imageViews.count - 1)
        while randInt == prev {
            randInt = Int.random(in: 0...imageViews.count - 1)
        }
        imageViews[randInt].isHidden = false
        prev = randInt
    }
    
    @IBAction func didTapNext(_ sender: UIButton) {
        if firstTextField.text!.isEmpty || lastTextField.text!.isEmpty || schoolTextField.text!.isEmpty {
            let alert = "Enter all information:\nFirst Name / Last Name / School"
            
            let alertController = UIAlertController(title: "Alert", message: alert, preferredStyle: .alert)
                    
            // A way to dismiss the box once it pops up
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    
            // Passing this action to the alert controller so it can be dismissed
            alertController.addAction(action)
                    
            present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "goToNext", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNext" {
            let destinationVC = segue.destination as? QuestionsViewController
            
            if firstTextField.text != nil && lastTextField.text != nil && schoolTextField.text != nil {
                destinationVC?.first = firstTextField.text!
                destinationVC?.last = lastTextField.text!
                destinationVC?.school = schoolTextField.text!
            }
        }
    }
    
    
    @IBAction func changeBackgroundColor(_ sender: Any) {
        view.backgroundColor = colors.randomElement()
    }
}

