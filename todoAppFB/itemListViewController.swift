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
     
        // Do any additional setup after loading the view.
    }

    @IBAction func doneBtn(_ sender: Any) {
        self.getFIRdata()

    }
    
    
    
    func getFIRdata() {

        if let ref = ref {
            ref.observeSingleEvent(of: .value, with: { snapshot in
                
                if !snapshot.exists() {return}
                print(snapshot.value!)
                if let postDict = snapshot.value as? [String : AnyObject] {
                    for key in postDict.keys {
                        if let mainDict = postDict[key] as? [String: AnyObject]{
                            let Id =    key
                            let name = mainDict["name"] as? String
                            let cost = mainDict["cost"] as? String
                            let location = mainDict["location"] as? String
                            let description = mainDict["description"] as? String
                            let profileURL = mainDict["profileURL"] as? String ?? ""
    
                            self.arrdata.append(Chatmodel(id: Id, name: name!, cost: cost!, description: description!, location: location!,profileURL: profileURL))
                        }
                    }
                }

                self.itemTblView.reloadData()
            })
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        
  //      let chatmodel = arrdata[indexPath.row]
        
    }
}
