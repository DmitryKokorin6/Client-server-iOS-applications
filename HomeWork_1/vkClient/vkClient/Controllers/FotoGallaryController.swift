//
//  FotoGallaryController.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 11.07.2022.
//

import UIKit

class FotoGallaryController: UIViewController {

    

    @IBOutlet weak var galleryView: FotoGallery!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = [UIImage(named: "IMG_90C0B1091B97-1")!, UIImage(named: "IMG_60249539DDAC-1")!, UIImage(named: "IMG_D60F1A5EF7F6-1")!]
        galleryView.setImages(images: images)
    }
}

