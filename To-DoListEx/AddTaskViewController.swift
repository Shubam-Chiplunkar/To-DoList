//
//  AddTaskViewController.swift
//  To-DoListEx
//
//  Created by mayank ranka on 18/04/23.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var field: UITextField!
    
    var update: ( () -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(saveButton))
        field.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveButton()
        return true
    }
    
    @objc func saveButton(){
        guard let text = field.text, !text.isEmpty else{
            return
        }
        guard let count = UserDefaults.standard.value(forKey: "count") as? Int else{
            return
        }
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        update!()
        self.navigationController?.popToRootViewController(animated: true)
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
