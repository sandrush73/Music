 //
//  ItemCell.swift
//  DreamLister
//
//  Created by Rusheel  Sandri on 9/6/18.
//  Copyright © 2018 Rusheel  Sandri. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemDesip: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemImage: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configCell(item: Items){
        itemTitle.text = item.title
        itemPrice.text = "$\(item.price)"
        itemDesip.text = item.details
    }

   
}
