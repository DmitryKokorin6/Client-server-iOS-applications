//
//  FotoCollectionViewCell.swift
//  CollectionTest
//
//  Created by Дмитрий Кокорин on 07.06.2022.
//

import UIKit

class FotoCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var likeControlVIew: LikeControlView!
    
    @IBOutlet weak var fotoImageView: UIImageView!
    
    
    var onLikeClosure: ((Bool, Int) -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView.image = nil
        likeControlVIew.configure(isLiked: false, counter: 0)
        
    }
    
    func configure(image: UIImage?, isLiked: Bool, likeCounter: Int, onLikeClosure: @escaping  (Bool, Int) -> Void) {
        fotoImageView.image = image
        fotoImageView.layer.cornerRadius = 75
        likeControlVIew.configure(isLiked: isLiked, counter: likeCounter)
        likeControlVIew.delegate = self
        self.onLikeClosure = onLikeClosure
    }
 

}

extension FotoCollectionViewCell: LikeControlProtocol {
    func pressLike(likeState: Bool, currentCount: Int) {
        print("counter\(currentCount)")
        print(likeState ? "true" : "false")
        self.onLikeClosure?(likeState, currentCount)
    }

}
