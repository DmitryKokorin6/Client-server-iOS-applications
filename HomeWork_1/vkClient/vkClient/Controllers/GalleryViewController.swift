//
//  GalleryViewController.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 07.06.2022.
//

import UIKit

class GalleryViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fotoAlbum = [MyPhoto]()
    var fotoAlbumIndex = 0
    var interactiveAnimate : UIViewPropertyAnimator!
    
    
    let customViewCellWithReuseIdentifier = "customViewCellWithReuseIdentifier"
    let fotoCollectionViewCell = "FotoCollectionViewCell"
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: fotoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: customViewCellWithReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        fotoAlbum = Storage.shared.friends[fotoAlbumIndex].fotoAlbum

    }
    


}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 10
        let cellWidth = width / 3 - whiteSpaces
        CGSize(width: cellWidth, height: cellWidth)
        return CGSize(width: cellWidth, height: cellWidth + 120)
    }
}
extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fotoAlbum.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customViewCellWithReuseIdentifier, for: indexPath) as! FotoCollectionViewCell
         
        
        
        
        
        let image = UIImage(named: self.fotoAlbum[indexPath.item].index)
        let localFotoAlbumIndex = fotoAlbumIndex
        let currentFotoAlbumIndex = Storage.shared.friends[localFotoAlbumIndex].fotoAlbum

        cell.configure(image: image,
                       isLiked: currentFotoAlbumIndex[indexPath.item].isLiked,
                       likeCounter: currentFotoAlbumIndex[indexPath.item].likeCounter,
                       onLikeClosure: { isLikePressed, currentCounter in
            print("counter\(currentCounter)")
            print(isLikePressed ? "true" : "false")
            Storage.shared.friends[localFotoAlbumIndex].fotoAlbum[indexPath.item].isLiked = isLikePressed
            Storage.shared.friends[localFotoAlbumIndex].fotoAlbum[indexPath.item].likeCounter = currentCounter
            })
        
        return cell
        
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        let fullScreenView = UIView(frame: self.view.bounds)
        let fullScreenImageView = UIImageView(frame: fullScreenView.frame)
        fullScreenView.addSubview(fullScreenImageView)
        let image = Storage.shared.friends[fotoAlbumIndex].fotoAlbum[indexPath.item].index
        fullScreenImageView.image = UIImage(named: image)
        self.view.addSubview(fullScreenView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        fullScreenView.addGestureRecognizer(tap)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(pan)
        
        
    }
    
    
    @objc func onTap(_ recognizer: UITapGestureRecognizer) {
        guard let targetView = recognizer.view else { return }
        targetView.removeFromSuperview()
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimate = UIViewPropertyAnimator(duration: 3,
                                                        curve: .linear,
                                                        animations: { [weak self] in
                self?.collectionView.transform = CGAffineTransform(translationX: -100, y: 0)
            })
        case .changed:
            let translation = recognizer.translation(in: self.view)
            print(translation.x)
           // if translation.x < 0 {
                let translationY = -translation.x
                interactiveAnimate.fractionComplete = translationY / 500
      //  }
            
        case .ended:
            interactiveAnimate.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:  return
        }
    }
    
    
}
