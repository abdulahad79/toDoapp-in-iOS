//
//  DetailViewController.swift
//  todoAppFB
//
//  Created by abdul ahad on 10/03/2019.
//  Copyright © 2019 abdul ahad. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseStorage

class DetailViewController: UIViewController,UINavigationControllerDelegate {

    @IBOutlet weak var diTitle: UILabel!
    @IBOutlet weak var diCost: UILabel!
    @IBOutlet weak var diLocation: UILabel!
    @IBOutlet weak var diDescription: UILabel!
    @IBOutlet weak var diImgView: UIImageView!
    
    var model: Chatmodel = Chatmodel();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        diTitle.text = model.name
        diCost.text =  model.cost
        diLocation.text =  model.location
        diDescription.text =  model.description
        
            let url = URL(string: (model.profileURL)!)
            if let url = url as? URL{
                KingfisherManager.shared.retrieveImage(with: url as! Resource, options: nil, progressBlock: nil) { (image , error , cache, imageURL) in
                    self.diImgView.image = image
                    self.diImgView.kf.indicatorType = .activity
                }
            }
    }

}
