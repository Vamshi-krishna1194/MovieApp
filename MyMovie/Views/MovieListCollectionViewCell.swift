//
//  MovieListCollectionViewCell.swift
//  MyMovie
//
//  Created by vamshi krishna on 23/06/23.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
extension UICollectionViewCell {
    func addShadow(corner: CGFloat = 10, color: UIColor = .black, radius: CGFloat = 2, offset: CGSize = CGSize(width: 0, height: 0), opacity: Float = 0.2) {
        let cell = self
        cell.contentView.layer.borderWidth = 0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = color.cgColor
        cell.layer.shadowOffset = offset
        cell.layer.shadowRadius = radius
        cell.layer.shadowOpacity = opacity
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
}
//extension UIView {
//    func applyGradient() {
//        let gradient = CAGradientLayer()
//        gradient.opacity = 0.1
//        gradient.colors = [UIColor.purple.cgColor,
//                           UIColor.green.cgColor,
//                           UIColor.cyan.cgColor]   // your colors go here
//        gradient.locations = [0.0, 0.5, 1.0]
//        gradient.frame = self.bounds
//        self.layer.insertSublayer(gradient, at: 0)
//    }
//}
