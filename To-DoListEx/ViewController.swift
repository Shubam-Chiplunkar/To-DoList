//
//  ViewController.swift
//  To-DoListEx
//
//  Created by mayank ranka on 18/04/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var task = [String]()

    @IBOutlet weak var myTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableview.delegate = self
        myTableview.dataSource = self
//        myTableview.backgroundColor = .red
        self.title = "Tasks"
        if UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButton))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = task[indexPath.row]
        return cell
    }

    func updateTask(){
        
    }
    @objc func addButton(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        vc.title = "Add Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTask()
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

