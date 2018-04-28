//
//  HighlightableTableViewCell.swift
//  SectionSelectTable
//
//  Created by Sergey Markin on 28.04.2018.
//  Copyright © 2018 Profi.RU. All rights reserved.
//

import UIKit

protocol MyTableViewCellDelegate: class {
    
    func didToggle(highlighted: Bool, animated: Bool, in cell: UITableViewCell)
    
}

class HighlightableTableViewCell: UITableViewCell {
    
    weak var delegate: MyTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupBackground(highlighted: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setupBackground(highlighted: false)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        delegate.didToggle(highlighted: highlighted, animated: animated, in: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setupBackground(highlighted: isSelected)
    }
    
    private func setupBackground(highlighted: Bool) {
        let bgColor: UIColor = highlighted ? .darkGray : .white
        backgroundColor = bgColor
        textLabel?.backgroundColor = bgColor
    }
    
}
