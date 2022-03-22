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
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(withTask task: Task, done: Bool = false) {
        
        if done {
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
            self.titleLabel.attributedText = attributedString
            
            self.dateLabel.text = ""
            self.locationLabel.text = ""
            
        } else {
            if let date = task.date {
                self.dateLabel.text = self.dateFormatter.string(from: date)
            }
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue])
            self.titleLabel.attributedText = attributedString
            self.titleLabel.text = task.title
            self.locationLabel.text = task.location?.name
        }
    }
}
