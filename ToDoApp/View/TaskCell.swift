//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 28.01.2022.
//

import UIKit

class TaskCell: UITableViewCell {
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(withTask task: Task) {
    }
}
