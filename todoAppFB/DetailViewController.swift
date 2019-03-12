//
//  DetailViewController.swift
//  todoAppFB
//
//  Created by abdul ahad on 10/03/2019.
//  Copyright © 2019 abdul ahad. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var diTitle: UILabel!
    @IBOutlet weak var diCost: UILabel!
    @IBOutlet weak var diLocation: UILabel!
    @IBOutlet weak var diDescription: UILabel!
    @IBOutlet weak var diImgView: UIImageView!
    
    //var model: Chatmodel;
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        diTitle.text = model.name
//        diCost.text = model.cost
//        diLocation.text = model.location
//        diDescription.text = model.description
//        
        
        // Do any additional setup after loading the view.
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
