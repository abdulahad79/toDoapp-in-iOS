//
//  itemListViewController.swift
//  todoAppFB
//
//  Created by abdul ahad on 11/03/2019.
//  Copyright © 2019 abdul ahad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class itemListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    var ref: DatabaseReference? = nil
    var arrdata = [Chatmodel]()
  
    @IBOutlet weak var itemTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "toDo")
        
        itemTblView.dataSource = self
        itemTblView.delegate = self
        self.getFIRdata()
        
    itemTblView.allowsMultipleSelectionDuringEditing = true
        // Do any additional setup after loading the view.

    }

    func getFIRdata() {

        if let ref = ref {
//            // gets all data
//            ref.observe(.value) { (snapshot) in
//                print(snapshot)
//            }
            
            // gets new data
            ref.observe(.childAdded) { (snapshot) in
                print(snapshot)
                print(snapshot.value!)
                
                if let dict = snapshot.value as? [String: AnyObject] {
                    let Id =    snapshot.key
                    let name = dict["name"] as? String
                    let cost = dict["cost"] as? String
                    let location = dict["location"] as? String
                    let description = dict["description"] as? String
                    let profileURL = dict["profileURL"] as? String ?? ""
                    
                    let model = Chatmodel(id: Id, name: name!, cost: cost!, description: description!, location: location!,profileURL: profileURL)
                    self.arrdata.insert(model, at: 0)
                    self.itemTblView.reloadData()
                }
                
//                if let postDict = snapshot.value as? [String : AnyObject] {
//                    for key in postDict.keys {
//
//                    }
//                    self.itemTblView.reloadData()
//                }
            }
            
            // called on data removal
            ref.observe(.childRemoved) { (snapshot) in
                print(snapshot)
            }
            
            // called on data change
            ref.observe(.childChanged) { (snapshot) in
                print(snapshot)
            }
            
//
//            ref.observe(.childChanged, with: { (snapshot) in
//                if !snapshot.exists() {return}
//                print(snapshot.value!)
//                if let postDict = snapshot.value as? [String : AnyObject] {
//                    for key in postDict.keys {
//                        if let dict = postDict[key] as? [String: AnyObject]{
//                            let Id =    key
//                            let name = dict["name"] as? String
//                            let cost = dict["cost"] as? String
//                            let location = dict["location"] as? String
//                            let description = dict["description"] as? String
//                            let profileURL = dict["profileURL"] as? String ?? ""
//
//                            self.arrdata.append(Chatmodel(id: Id, name: name!, cost: cost!, description: description!, location: location!,profileURL: profileURL))
//                        }
//                    }
//                }
//                self.itemTblView.reloadData()
//            })
        }
        
        self.itemTblView.reloadData()
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150;
    }
  
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
      
        cell.chatmodel = arrdata[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          
            if let model =  self.arrdata[indexPath.row] as? Chatmodel {
                self.arrdata.remove(at: indexPath.row)
                self.itemTblView.reloadData()
                Database.database().reference().child("toDo").child(model.id!).removeValue()
            
                itemTblView.reloadData()
            }
        }
        
//        if editingStyle == .delete {
//            arrdata.remove(at: indexPath.row)
//            itemTblView.deleteRows(at: [indexPath], with: .bottom)
//        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController{
            destination.model = arrdata[(itemTblView.indexPathForSelectedRow?.row)!]
        }
    }

}
