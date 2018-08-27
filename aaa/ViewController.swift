//
//  ViewController.swift
//  aaa
//
//  Created by Developer on 22/07/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var tableView : UITableView!
    
    var context:NSManagedObjectContext = {
        return AppDelegate.shared.persistentContainer.viewContext
    }()
    
    let cellID = "cellId"
    let studentStr = "Student"
    let departmentStr = "Department"
    let teamStr = "Team"
    let personStr = "Person"
    
    var studentClass = [StudentMO]()
    var departmentClass = [DepartmentMO]()
    var personClass = [Person]()
    var teamClass = [Team]()
    
    var studentObj : StudentMO?
    var departmentObj : DepartmentMO?
    var personObj : Person?
    
    
    lazy var refreshControl:UIRefreshControl = {
        let rec = UIRefreshControl()
        
        self.tableView.addSubview(rec)
        return rec
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    
    func save(){
        
        do {
           try self.context.save()
        }catch let err {
            print(err.localizedDescription)
        }
    }
    
    
    
    @IBAction func addClick(_ sender: Any) {
        
       // self.showAlert(studentName: nil, departmentName: nil)
        self.showAlert(person: nil, team: nil)
    }
    
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.load()
    
        
    }
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing{
            self.load()
        }
    }
    
    
    // Alert For Student
    func showAlert(person : String?, team : String?){
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {
            textField in
            textField.text = person
            textField.placeholder = "Name"
        })
        
        alert.addTextField(configurationHandler: {
            textField in
            textField.text = team
            textField.placeholder = "Team"
        })
        
        let saveButton = UIAlertAction(title: "Save", style: .destructive, handler: {
            Void in
            
            guard  let pName = alert.textFields?[0].text else{
                return
            }
            guard let tName = alert.textFields?[1].text else {
                return
            }
            
            if self.personObj == nil {
                self.personObj = NSEntityDescription.insertNewObject(forEntityName: self.personStr, into: self.context) as? Person
                self.personObj?.id =  0//Int16(Date().timeIntervalSince1970)
                let teamObj = NSEntityDescription.insertNewObject(forEntityName: self.teamStr, into: self.context) as? Team
                teamObj?.id = 0 //Int16(Date().timeIntervalSince1970)
                self.personObj?.relationshipTeam = teamObj
            }
            
            self.personObj?.name =  pName
            self.personObj?.relationshipTeam?.name = tName
            
            self.save()
            self.load()
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
     // Alert For Student
     func showAlert(studentName : String?, departmentName : String?){
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {
            textField in
            textField.text = studentName
            textField.placeholder = "Student Name"
        })
        
        alert.addTextField(configurationHandler: {
            textField in
            textField.text = departmentName
            textField.placeholder = "Department"
        })
        
        let saveButton = UIAlertAction(title: "Save", style: .destructive, handler: {
            Void in
            
            guard  let sName = alert.textFields?[0].text else{
                return
            }
            
            
            guard let dept = alert.textFields?[1].text else {
                return
            }
            
            if self.studentObj == nil {
                self.studentObj = NSEntityDescription.insertNewObject(forEntityName: self.studentStr, into: self.context) as? StudentMO
            }
            
            self.studentObj?.name =  sName
            self.studentObj?.department = dept
            
            if self.departmentObj == nil {
                
                self.departmentObj = NSEntityDescription.insertNewObject(forEntityName: self.departmentStr, into: self.context) as? DepartmentMO
                
            }
            
            self.departmentObj?.name = dept
            self.studentObj?.newRelationship = self.departmentObj
            
            self.save()
            self.load()
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func load(){
        
        let requestStud = StudentMO.fetch()//NSFetchRequest<NSFetchRequestResult>(entityName: studentStr)
        requestStud.returnsObjectsAsFaults = false
        
        let requestDep = DepartmentMO.fetch()
        requestDep.returnsObjectsAsFaults = false
        
        let requestPerson = Person.fetch()
        requestPerson.returnsObjectsAsFaults = false
        
        do {
            
                self.studentClass = try context.fetch(requestStud)
                self.departmentClass = try context.fetch(requestDep)
                self.personClass = try context.fetch(requestPerson)
            
             print(studentClass.count, departmentClass.count, personClass.count,teamClass.count)
            
        }catch let err {
            print(err.localizedDescription)
        }
       
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    
}


extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personClass.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
//        let studentObj = personClass[indexPath.row]
//
//        let sname = studentObj.name!
//        let dept = studentObj.department!
//        let depp = departmentClass[indexPath.row].name!
        
        let personObject = personClass[indexPath.row]
        
      
        cell.textLabel?.text = personObject.name!+"-"+personObject.relationshipTeam!.name!
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
//            let obj = studentClass[indexPath.row]
//            let obj1 = departmentClass[indexPath.row]
//
//            context.delete(obj)
//            context.delete(obj1)
            
            let obj = personClass[indexPath.row]
            context.delete(obj)
            save()
            load()
            tableView.reloadData()
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if studentClass.count > indexPath.row{
//
//            self.studentObj = studentClass[indexPath.row]
//            self.departmentObj = departmentClass[indexPath.row]
//
//            self.showAlert(studentName: studentObj?.name, departmentName: studentObj?.department)
//
//
//        }
        
        if self.personClass.count > indexPath.row {
            self.personObj = personClass[indexPath.row]
            self.showAlert(person: personObj?.name, team: personObj?.relationshipTeam?.name)
        }
        
    }
    
    
    
}
