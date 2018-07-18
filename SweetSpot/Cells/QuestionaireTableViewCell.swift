//
//  QuestionaireTableViewCell.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 6/30/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

protocol QuestionCellDelegate {
    func doSend(selection: Any, fromCell cell: UITableViewCell)
}
class QuestionaireTableViewCell: UITableViewCell {

    @IBOutlet var btn_Selection: UIButton!
    @IBOutlet var lbl_Response: UILabel!
    
    var questionaireDelegate: QuestionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        lbl_Response.textColor = UIColor.AppColors.beige
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selection(_ sender: UIButton) {
        questionaireDelegate?.doSend(selection: lbl_Response.text, fromCell: self)
    }
}
