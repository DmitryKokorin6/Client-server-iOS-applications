//
//  LoginViewController.swift
//  vkClient
//
//  Created by Rodion Molchanov on 24.05.2022.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleImageView: UIImageView!
    
 
    
    
    @IBOutlet weak var leftCurcle: UIView!
    @IBOutlet weak var centerCurcle: UIView!
    @IBOutlet weak var rightCurcle: UIView!
    

    
    let toTabBarController = "toTabBarController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.alpha = 0
        passwordTextField.alpha = 0
        leftCurcle.layer.cornerRadius = 10
        centerCurcle.layer.cornerRadius = 10
        rightCurcle.layer.cornerRadius = 10
        centerCurcle.alpha = 0
        rightCurcle.alpha = 0
        animateView()
        animateTextField()
        
        //animateBlueView()
        
    }

    
//

    
    
    func animateTitleImageView() {
        UIView.animate(withDuration: 2,
                       delay: 0.3,
                       options: [.curveEaseOut],
                       animations: {
            [weak self] in
            let translation = CGAffineTransform(translationX: -10, y: -300)
            self?.titleImageView.transform = translation
            //self?.titleImageView.alpha = 0
        },
                       completion: nil)
    }
    
    
    func animateTextField() {
        UITextField.animate(withDuration: 3,
                            delay: 0,
                            options: [],
                            animations: {
            [weak self] in
            self?.userNameTextField.alpha = 1
            self?.passwordTextField.alpha = 1

        },
                            completion: nil)
    }

    func animateView() {
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            [weak self] in
            self?.leftCurcle.alpha = 0
            self?.centerCurcle.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0, options: []) {
                [weak self] in
                self?.centerCurcle.alpha = 0
                self?.rightCurcle.alpha = 1
        }
    completion: { _ in
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            [weak self] in
            self?.rightCurcle.alpha = 0
            self?.leftCurcle.alpha = 1
        }
    completion: { _ in
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            [weak self] in
            self?.animateView()
        }
    }
    }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("willAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("didAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("willDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("didDisappear")
    }
   
    func loginButtonSpring(){
        let animate = CASpringAnimation(keyPath: "position.y")
        animate.toValue = 400
        animate.duration = 3
        animate.mass = 1
        animate.stiffness = 50
        animate.damping = 5
        animate.initialVelocity = 6
         
        loginButton.layer.add(animate, forKey: nil)
//        UIView.animate(withDuration: 2,
//                       delay: 0.3,
//                       options: [.curveEaseOut],
//                       animations: {
//            [weak self] in
//            let translation = CGAffineTransform(translationX: 10, y: 300)
//            self?.loginButton.transform = translation
            //self?.titleImageView.alpha = 0
      //  },
                      // completion: nil)
    }
    
    
    func fillDate() -> [Friend] {
        let myFoto = MyPhoto(index: "IMG_60249539DDAC-1")
        
        let friend1 = Friend(age: "20 лет", avatar: "IMG_D60F1A5EF7F6-1", name: "Красавица", fotoAlbum: [myFoto, myFoto, myFoto])
        let friend2 = Friend(age: "44 года", avatar: "IMG_60249539DDAC-1", name: "Батя", fotoAlbum: [myFoto])
        let friend3 = Friend(age: "18 лет", avatar: "IMG_90C0B1091B97-1", name: "Мамочка", fotoAlbum: [myFoto, myFoto])
        
        var friendsArray = [Friend]()

        
        friendsArray.append(friend1)
        friendsArray.append(friend2)
        friendsArray.append(friend3)
        
        for _ in 0...30 {
            friendsArray[1].fotoAlbum.append(myFoto)
        }
        
        return friendsArray
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
//        loginButtonSpring()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loginButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.loginButton.setTitle("", for: .normal)
        }) { _ in
            // Вычисляем конечный размер кружка загрузки
            let finalSize = self.loginButton.frame.size.height
            
            // Показываем кружок загрузки
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.center = self.loginButton.center
            activityIndicator.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            // Анимация увеличения кружка загрузки до размера кнопки
            UIView.animate(withDuration: 0.3) {
                activityIndicator.transform = CGAffineTransform(scaleX: finalSize / activityIndicator.frame.size.width, y: finalSize / activityIndicator.frame.size.height)
            } completion: { _ in
                // По окончании анимации переходите на следующий экран
//                if self.userData() {
//                    self.performSegue(withIdentifier: "goToMain", sender: nil)
//                } else {
//                    self.allertNotify()
//                }
            }
        }
        
        animateTitleImageView()
        Storage.shared.friends = fillDate()
        
        
        
//        UIView.animate(withDuration: 3) { [weak self] in
//            self?.yellowView.transform = CGAffineTransform.init(translationX: 150, y: 0)
//        } completion: { _ in
//            UIView.animate(withDuration: 3) { [weak self] in
//                self?.yellowView.transform = CGAffineTransform.init(translationX: 0, y: 100)
//            } completion: { _ in
//                UIView.animate(withDuration: 3) { [weak self] in
//                    self?.yellowView.transform = CGAffineTransform.init(translationX: -150, y: 0)
//                } completion: { [weak self] _ in
//                    guard let self = self else { return }
//                    self.performSegue(withIdentifier: self.toTabBarController, sender: nil)
//                }
//            }
//        }
        
//        UIView.animate(withDuration: 3,
//                       delay: 0,
//                       options: []) {
//            [weak self] in
//                self?.yellowView.transform = CGAffineTransform.init(translationX: 150, y: 0)
//        } completion: { _ in
//
//        }
//
//        UIView.animate(withDuration: 3,
//                       delay: 3,
//                       options: []) {
//            [weak self] in
//                self?.yellowView.transform = CGAffineTransform.init(translationX: 0, y: 100)
//        } completion: { _ in
//
//        }
//
//        UIView.animate(withDuration: 3,
//                       delay: 6,
//                       options: []) {
//            [weak self] in
//                self?.yellowView.transform = CGAffineTransform.init(translationX: -150, y: 0)
//        } completion: { _ in
//
//        }
        


//        if let login = userNameTextField.text,
//           login == "root" {
//            userNameTextField.backgroundColor = UIColor.green
//        }
//        else {
//            userNameTextField.backgroundColor = UIColor.magenta
//        }
//
//        if let password = passwordTextField.text,
//           password == "1234" {
//            passwordTextField.backgroundColor = UIColor.green
//        }
//        else {
//            passwordTextField.backgroundColor = UIColor.magenta
//        }
    }
    
    
    
}
