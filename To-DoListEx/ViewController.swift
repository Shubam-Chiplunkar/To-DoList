//
//  ViewController.swift
//  To-DoListEx
//
//  Created by mayank ranka on 18/04/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var tasks = [String]()

    @IBOutlet weak var myTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableview.delegate = self
        myTableview.dataSource = self
//        myTableview.backgroundColor = .red
        self.title = "Tasks"
        if !UserDefaults.standard.bool(forKey: "setup"){
            UserDefaults.standard.set(true, forKey: "setup")
            UserDefaults.standard.set(0, forKey: "count")
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButton))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }

    func updateTask(){
        tasks.removeAll()
        guard let count = UserDefaults.standard.value(forKey: "count") as? Int else{
            return
        }
        for x in 0..<count{
            if let task = UserDefaults.standard.value(forKey: "task_\(x+1)") as? String{
                tasks.append(task)
            }
            
        }
        myTableview.reloadData()
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

