//
//  TableViewCell.swift
//  TableViewTest
//
//  Created by Дмитрий Кокорин on 05.06.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    var closure: (() -> Void)?
    
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        fotoImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        closure = nil
    }
    
    func configure(image: UIImage?, name: String?, description: String?, closure: @escaping () -> Void) {
        fotoImageView.image = image
        fotoImageView.layer.cornerRadius = 60
        nameLabel.text = name
        self.closure = closure
        if let description = description {
            descriptionLabel.text = description
            descriptionLabel.textColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        } else {
            descriptionLabel.text = "no description"
            descriptionLabel.textColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
        
    }
    
    func configure(_ group: Group) {
        fotoImageView.image = UIImage(named: group.avatar)
        nameLabel.text = group.name
        nameLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        descriptionLabel.text = group.desc
        descriptionLabel.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
    }
    
    func pressFotoImageViewSpring(){
        let animate = CASpringAnimation(keyPath: "position.x")
        animate.toValue = 200
        animate.duration = 3
        animate.mass = 1
        animate.stiffness = 50
        animate.damping = 5
        animate.initialVelocity = 6
        
        fotoImageView.layer.add(animate, forKey: nil)
    }
    
    @IBAction func pressFotoImageView(_ sender: UIButton) {
        //pressFotoImageViewSpring()
        UIView.animate(withDuration: 3,
                       delay: 0,
                       options: [.autoreverse]) {
            [weak self] in
            self?.fotoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self?.fotoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self?.fotoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self?.fotoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self?.fotoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self?.fotoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self?.fotoImageView.layer.speed = 3
        } completion: { [weak self] _ in
            self?.closure?()
        }

        
//        UIView.animate(withDuration: 3,
//                       delay: 0,
//                       options: [.autoreverse]) {
//            [weak self] in
//                self?.fotoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//            self?.fotoImageView.layer.speed = 5
//        } completion: { [weak self] _ in
//            self?.closure?()
//        }
        
//        UIView.animate(withDuration: 3) {
//            [weak self] in
//            self?.fotoImageView.transform = CGAffineTransform(translationX: 0.5, y: 0.5)
//        } completion: { [weak self] _ in
//            self?.closure?()
//        }

    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
