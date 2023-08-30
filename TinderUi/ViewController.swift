//
//  ViewController.swift
//  TinderUi
//
//  Created by Vikram Kunwar on 29/08/23.
//

import UIKit

class ViewController: UIViewController {
    var imageIndex = 0
    let images = ["image1", "image2", "image3", "image4","Vikram"]
    let names = ["Elena Markus", "Ana-Maria", "Katrina", "Emily John","Vikram Kunwar"]
    var nextLabel: UILabel!

    var nextImageView: UIImageView!
    
    @IBOutlet weak var colorView: UIView!
    


    
    @IBOutlet weak var tinderimages: UIImageView!
    
    @IBOutlet weak var tinderLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        tinderimages.layer.cornerRadius = 20 // Rounded corners
        tinderimages.layer.masksToBounds = false // Al
        tinderimages.clipsToBounds = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
                tinderimages.isUserInteractionEnabled = true
                tinderimages.addGestureRecognizer(panGesture)
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDragGesture(_:)))
                view.addGestureRecognizer(dragGesture)
        tinderimages.image = UIImage(named: images[imageIndex])
        

        nextImageView = UIImageView(frame: CGRect(x: tinderimages.frame.origin.x, y: tinderimages.frame.origin.y, width: tinderimages.frame.width, height: tinderimages.frame.height))
                nextImageView.layer.cornerRadius = 20
                nextImageView.clipsToBounds = true
                view.insertSubview(nextImageView, belowSubview: tinderimages)
                
        
      
                nextImageView.image = UIImage(named: images[(imageIndex + 1) % images.count])
        
                nextLabel = UILabel(frame: tinderLabel.frame)
                nextLabel.font = tinderLabel.font
                nextLabel.textColor = tinderLabel.textColor
                nextLabel.textAlignment = tinderLabel.textAlignment
                view.insertSubview(nextLabel, aboveSubview: nextImageView)

                updateNextImageAndLabel()
                nextLabel.alpha = 0

                // Set the initial images and label
                tinderimages.image = UIImage(named: images[imageIndex])
                tinderLabel.text = names[imageIndex % names.count]
        
        
        
    }
    
    @IBAction func rewindBtn(_ sender: UIButton){
        print("Tapped")
    }
    
    @IBAction func cancelBtn(_ sender: UIButton){
       
        
    }
    
    @IBAction func likeBtn(_ sender: UIButton){
  
        
    }
    
    @IBAction func superLikeBtn(_ sender: UIButton){
        print("SuperLikeTapped")
        
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let xFromCenter = tinderimages.center.x - view.center.x
        
        // Divide the translation by 2 to make the swipe slower
        tinderimages.center = CGPoint(x: tinderimages.center.x + translation.x / 2, y: tinderimages.center.y + translation.y / 2)
        
        tinderimages.transform = CGAffineTransform(rotationAngle: xFromCenter / view.frame.width * -0.785)
        
        nextImageView.image = UIImage(named: images[(imageIndex + 1) % images.count])
        nextLabel.text = names[(imageIndex + 1) % names.count]
        
        nextImageView.alpha = abs(xFromCenter) / view.center.x
        nextLabel.alpha = abs(xFromCenter) / view.center.x
        
        switch sender.state {
            
        case .ended:
            if tinderimages.center.x < 75 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                    self.tinderimages.center = CGPoint(x: self.tinderimages.center.x - 200, y: self.tinderimages.center.y)
                    self.tinderimages.alpha = 0
                    self.tinderimages.transform = CGAffineTransform(rotationAngle: -1)
                    self.tinderLabel.alpha = 0
                    self.nextImageView.alpha = 1
                    self.nextLabel.alpha = 1
                    
                    
                }, completion: { _ in
                    self.tinderimages.transform = .identity
                    self.tinderimages.alpha = 1
                    self.tinderLabel.alpha = 1
                    self.nextLabel.alpha = 1
                    
                    self.nextLabel.transform = .identity
                    self.tinderimages.center = self.view.center
                    self.imageIndex = (self.imageIndex + 1) % self.images.count
                    self.updateNextImageAndLabel()
                    self.tinderimages.image = UIImage(named: self.images[self.imageIndex])
                    self.tinderLabel.text = self.names[self.imageIndex % self.names.count]
                })
                return
            } else if tinderimages.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                    self.tinderimages.center = CGPoint(x: self.tinderimages.center.x + 200, y: self.tinderimages.center.y)
                    self.tinderimages.alpha = 0
                    self.tinderimages.transform = CGAffineTransform(rotationAngle: 1)
                    self.tinderLabel.alpha = 0
                    self.nextLabel.alpha = 0
                    self.nextLabel.transform = CGAffineTransform(translationX: 200, y: 0)
                    self.nextImageView.alpha = 1
                    self.nextLabel.alpha = 0.1
                    
                }, completion: { _ in
                    self.tinderimages.transform = .identity
                    self.tinderimages.alpha = 1
                    self.tinderimages.center = self.view.center
                    self.imageIndex = (self.imageIndex + 1) % self.images.count
                    self.updateNextImageAndLabel()
                    self.tinderLabel.alpha = 1
                    self.nextLabel.alpha = 1
                    self.nextLabel.transform = .identity
                    self.tinderimages.image = UIImage(named: self.images[self.imageIndex])
                    self.tinderLabel.text = self.names[self.imageIndex % self.names.count]
                })
                return
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                self.tinderimages.center = self.view.center
                self.tinderimages.transform = .identity
                self.tinderLabel.alpha = 1
                self.nextLabel.alpha = 0
                self.nextLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.nextImageView.alpha = 0
                self.nextLabel.alpha = 0
                
            }, completion: nil)
            
        default:
            break
        }
    }

    
    @objc func handleDragGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        let xFromCenter = tinderimages.center.x - view.center.x
        
        if abs(xFromCenter) < view.bounds.width / 2 {
            nextImageView.alpha = abs(xFromCenter) / (view.bounds.width / 2)
            nextImageView.transform = CGAffineTransform(translationX: translation.x / 10, y: translation.y / 10)
            nextLabel.alpha = abs(xFromCenter) / (view.bounds.width / 2)
            nextLabel.transform = CGAffineTransform(translationX: translation.x / 10, y: translation.y / 10)
        }
        
        gesture.setTranslation(CGPoint.zero, in: view)
        
        if gesture.state == .ended {
            nextImageView.alpha = 0
            nextImageView.transform = CGAffineTransform.identity
            nextLabel.alpha = 0
            nextLabel.transform = CGAffineTransform.identity
            
            if abs(xFromCenter) > view.bounds.width / 2 {
                // User dragged far enough to show the next image
                
                // Load the next image and label
                imageIndex += xFromCenter > 0 ? 1 : -1
                if imageIndex < 0 {
                    imageIndex += images.count
                } else if imageIndex >= images.count {
                    imageIndex -= images.count
                }
                
                updateNextImageAndLabel()
                
                // Animate the current image off the screen and back to its original position and transform, then set the next image as its image and reset its position and transform
                UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseIn, animations: {
                    self.tinderimages.center.x += xFromCenter > 0 ? self.view.bounds.width : -self.view.bounds.width
                    self.nextLabel.alpha = 1
                    self.nextLabel.transform = .identity
                    self.tinderimages.transform = CGAffineTransform.identity
                }, completion: { _ in
//                    self.tinderimages.center = self.view.center
                    self.tinderimages.image = self.nextImageView.image
                    self.tinderLabel.text = self.names[self.imageIndex % self.names.count]
                    
                    
                    UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseOut, animations: {
                        self.tinderimages.transform = CGAffineTransform.identity
                    }, completion: nil)
                })
            } else {
                // User did not drag far enough to show the next image
                
                UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseOut, animations: {
                    self.tinderimages.transform = CGAffineTransform.identity
                    self.nextLabel.alpha = 0
                    self.nextLabel.transform = .identity
                }, completion: nil)
            }
        }
    }
    
    func updateNextImageAndLabel() {
            let nextImageIndex = (imageIndex + 1) % images.count
            
            nextImageView.image = UIImage(named: images[nextImageIndex])
            nextLabel.text = names[nextImageIndex % names.count]
        }
    
    




}

