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
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(withTask task: Task) {
        self.titleLabel.text = task.title
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        
        if let date = task.date {
            self.dateLabel.text = df.string(from: date)
        }
        
        self.locationLabel.text = task.location?.name
    }
}
