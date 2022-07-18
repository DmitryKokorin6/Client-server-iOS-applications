//
//  Navigation.swift
//  vkClient
//
//  Created by Дмитрий Кокорин on 11.07.2022.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return CustomNavigationControllerPush()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return CustomNavigationControllerPop()
        }
        return nil
    }
    
    let interactiveTransition = CustomInteractiveTransition()
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.isAnimationStarted ? interactiveTransition : nil
    }
}

class CustomNavigationControllerPush: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0

func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        let containerViewFrame = transitionContext.containerView.frame
        
        let sourceViewFrame = CGRect(x: -containerViewFrame.height,
                                     y: 0,
                                     width: source.view.frame.height,
                                     height: source.view.frame.width
        )
        
        let destinationViewFrame = source.view.frame
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        destination.view.frame = CGRect(x: containerViewFrame.width,
                                        y: 0,
                                        width: source.view.frame.height,
                                        height: source.view.frame.width
        )
        
        UIView.animate(withDuration: duration,
                       animations: {
                source.view.transform = CGAffineTransform(rotationAngle: .pi/2)
                source.view.frame = sourceViewFrame
                
                destination.view.transform = .identity
                destination.view.frame = destinationViewFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}

class CustomNavigationControllerPop: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { return duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        let containerViewFrame = transitionContext.containerView.frame
        let sourceViewFrame = CGRect(x: containerViewFrame.width,
                                     y: 0,
                                     width: source.view.frame.height,
                                     height: source.view.frame.width
        )
        
        let destinationViewFrame = source.view.frame
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = CGRect(x: -containerViewFrame.height,
                                        y: 0,
                                        width: source.view.frame.height,
                                        height: source.view.frame.width
        )
        
        UIView.animate(withDuration: duration,
                       animations: {
                source.view.frame = sourceViewFrame
                source.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
                
                destination.view.transform = .identity
                destination.view.frame = destinationViewFrame
                
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }

}

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIPanGestureRecognizer(
                target: self,
                action: #selector(onPan(_:)))
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }
    var isAnimationStarted: Bool = false
    var complete: Bool = false

    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.isAnimationStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.y / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            
            self.complete = progress > 0.1

            self.update(progress)
        case .ended:
            self.isAnimationStarted = false
            self.complete ? self.finish() : self.cancel()
        case .cancelled:
            self.isAnimationStarted = false
            self.cancel()
        default: return
        }
    }
}
