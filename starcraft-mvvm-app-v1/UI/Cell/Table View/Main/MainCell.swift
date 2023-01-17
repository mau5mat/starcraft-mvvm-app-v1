//
//  MainCell.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

class MainCell: UITableViewCell {
    @IBOutlet weak private var cardView: UIView!
    @IBOutlet weak private var thumbnailImage: UIImageView!
    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var dividerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with viewModel: MainCellViewModel) {
        title.text = viewModel.typeToString()
        thumbnailImage.image = viewModel.thumbnailImage
        
        layoutIfNeeded()
    }

    func style() {
        // Anything to do with themeing gets passed through here from the parent view controller
        // and is used to style the cell
    }
    
    private func setupCardView() {
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.gray.cgColor
    }
}

extension MainCell: CellIdentifiable {
    static func nib() -> UINib {
        return UINib(nibName: "MainCell", bundle: nil)
    }
    
    static func reuseIdentifier() -> String {
        return "main_cell"
    }
}
