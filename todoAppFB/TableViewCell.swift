//
//  TableViewCell.swift
//  todoAppFB
//
//  Created by abdul ahad on 10/03/2019.
//  Copyright © 2019 abdul ahad. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleList: UILabel!
    @IBOutlet weak var costTitle: UILabel!
    @IBOutlet weak var itemImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var chatmodel: Chatmodel?{
        didSet{
            titleList.text = chatmodel?.name
            costTitle.text = chatmodel?.cost
            
            let url = URL(string: (chatmodel?.profileURL)!)
            if let url = url as? URL{
                KingfisherManager.shared.retrieveImage(with: url as! Resource, options: nil, progressBlock: nil) { (image , error , cache, imageURL) in
                    self.itemImg.image = image
                    self.itemImg.kf.indicatorType = .activity
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        }
    
    
}
