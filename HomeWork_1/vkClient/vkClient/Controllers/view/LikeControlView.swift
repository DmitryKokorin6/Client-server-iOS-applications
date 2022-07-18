//
//  LikeControlView.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 30.06.2022.
//

import UIKit

protocol LikeControlProtocol: AnyObject {
    func pressLike(likeState: Bool, currentCount: Int)
}

class LikeControlView: UIView {

    @IBOutlet weak var couterLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    
    weak var delegate: LikeControlProtocol?
    var couter = 0
    var isPressed = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func configure(isLiked: Bool, counter: Int) {
        isPressed = isLiked
        self.couter = counter
        likeState()
    }
    
    
    private func louderFileXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: "LikeControlView", bundle: bundle)
        let xibView = xib.instantiate(withOwner: self).first as! UIView
        return xibView
    }
    
    private func setup() {
        let xibView = louderFileXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(xibView)
    }
    
    func likeState() {
        if isPressed {
            heartImageView.image = UIImage(systemName: "heart.fill")
        }else {
            heartImageView.image = UIImage(systemName: "heart")
        }
        couterLabel.text = String(couter)
    }
    
    @IBAction func pressBigBlueButton(_ sender: UIButton) {
        isPressed = !isPressed
        if isPressed {
            couter += 1
        }else {
            couter -= 1
        }
        likeState()
        delegate?.pressLike(likeState: isPressed, currentCount: couter)
    }
 
}
