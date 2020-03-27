//
//  ViewController.swift
//  simpleList
//
//  Created by Mikhail Lozovyy on 3/27/20.
//  Copyright © 2020 Mikhail Lozovyy. All rights reserved.
//

import UIKit

struct TaskObject {
    var name: String!
    var dateCreated: Date!
    var dueDate: Date!
}

var taskArr: [TaskObject] = []

private let listReuseIdentifier = "listIdentifier"

class HomeController: UIViewController {
        
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableview.reloadData()
    }
    
    @IBAction func newTaskButton_Tapped(_ sender: Any) {
        self.performSegue(withIdentifier: "newTaskSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newTaskSegue" {
            let view = segue.destination as! NewTaskController
            
            view.createdTask = { didCreateTask in
                self.tableview.reloadData()
            }
        }
    }
    
}

extension HomeController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listReuseIdentifier, for: indexPath) as! ListCell
        
        let row = indexPath.row
        let formatter = DateFormatter()
        
        cell.titleLabel.text = taskArr[row].name
        
        // EXAMPLE
        // .medium for dateStyle will make date in form of March 27, 2020
        // .short for timeStyle will make time in form of 1:09 PM
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        cell.subTitleLabel.text = "Due: \(formatter.string(from: taskArr[row].dueDate))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

