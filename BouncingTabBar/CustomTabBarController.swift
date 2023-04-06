//
//  CustomTabBarController.swift
//  BouncingTabBar
//
//  Created by Ben Lee on 3/29/23.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var buttonsShowing: Bool = false
    let tabBarHeight: CGFloat = 128
    var didStyleTabBar: Bool = false
    
    let bounceView = BounceView()
    let item1 = UITabBarItem(title: nil, image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal), tag: 0)
    let item2 = UITabBarItem(title: nil, image: UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), tag: 1)
    
    let item3 = UITabBarItem(title: nil, image: UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal), tag: 2)
        
    let customTabBar: UITabBar = {
        let tb = UITabBar()
        tb.setTransparent()
        return tb
    }()
    
    let plusButtonMask: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        
        return button
    }()
    
    let photoButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "photoLifting")?.withRenderingMode(.alwaysOriginal), for: .normal)
        b.contentMode = .scaleAspectFill
        //b.backgroundColor = .white
        return b
    }()
    

    let cameraButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "cameraLifting")?.withRenderingMode(.alwaysOriginal), for: .normal)
        b.contentMode = .scaleAspectFit

        return b
    }()
    
    let cameraIconImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "cameraIcon")?.withRenderingMode(.alwaysOriginal))
        
        return iv
    }()
    
    let photoIconImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "photoIcon")?.withRenderingMode(.alwaysOriginal))
        
        return iv
    }()
    
    let folderIconImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "folderIcon")?.withRenderingMode(.alwaysOriginal))
        
        return iv
    }()
   
    
    let folderButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "folderLifting")?.withRenderingMode(.alwaysOriginal), for: .normal)
        b.contentMode = .scaleAspectFit

        return b
    }()
    
    let maskView:UIView = {
        let v = UIView()
        return v
    }()
    
//    var maskTapGestureRecognizer = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBlue()
        //setupBounceView()
        //setupCustomTabBar()
        //setupPlusButtonMask()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupLeftAndRightButtons()
        setupCameraButton()
        setupBounceView()
        setupCustomTabBar()

        hideButtons(left: true, right: true, center: true)
        setupPlusButtonMask()
        self.delegate = self
        customTabBar.delegate = self

//        let b = UIButton()
//        b.backgroundColor = .red
//        b.addTarget(self, action: #selector(testb), for: .touchUpInside)
//        view.addSubview(b)
//        b.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 200, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    }
    
   
    func setupBounceView() {
        view.addSubview(bounceView)
        bounceView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 246)
    }
    
    func setupCustomTabBar() {
        view.addSubview(customTabBar)
        customTabBar.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 128)
        
        customTabBar.items = [item1, item2, item3]
        customTabBar.delegate = self
    }
    
    func setupPlusButtonMask() {
        view.addSubview(plusButtonMask)
        plusButtonMask.translatesAutoresizingMaskIntoConstraints = false
        plusButtonMask.centerXAnchor.constraint(equalTo: self.customTabBar.centerXAnchor).isActive = true
        plusButtonMask.topAnchor.constraint(equalTo: customTabBar.topAnchor, constant: 16).isActive = true
        plusButtonMask.widthAnchor.constraint(equalToConstant: 50).isActive = true
        plusButtonMask.heightAnchor.constraint(equalToConstant: 50).isActive = true
        plusButtonMask.addTarget(self, action: #selector(plusButtonHeldDown), for: UIControl.Event.touchDown)
        plusButtonMask.addTarget(self, action: #selector(plusButtonLifted), for: UIControl.Event.touchUpInside)
    }
 
    func setupLeftAndRightButtons() {
        
        if photoButton.isDescendant(of: self.view) {
            print("left and right buttons alrready there")
            photoButton.setImage(UIImage(named: "photoLifting")?.withRenderingMode(.alwaysOriginal), for: .normal)
            folderButton.setImage(UIImage(named: "folderLifting")?.withRenderingMode(.alwaysOriginal), for: .normal)
            photoButton.frame = CGRect(x: 61, y: customTabBar.frame.origin.y - 53, width: 65.8, height: 53)
            folderButton.frame = CGRect(x: view.frame.size.width - 122, y: customTabBar.frame.origin.y - 52.1, width: 65.8, height: 53)
        } else {
            view.addSubview(photoButton)
            view.addSubview(folderButton)
            photoButton.frame = CGRect(x: 61, y: customTabBar.frame.origin.y - 53, width: 65.8, height: 53)
            
            photoButton.addSubview(photoIconImageView)
            photoIconImageView.anchor(top: photoButton.topAnchor, left: photoButton.leftAnchor, bottom: photoButton.bottomAnchor, right: photoButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            photoIconImageView.alpha = 0
            
            folderButton.frame = CGRect(x: view.frame.size.width - 122, y: customTabBar.frame.origin.y - 52.1, width: 65.8, height: 53)
            
            folderButton.addSubview(folderIconImageView)
            folderIconImageView.anchor(top: folderButton.topAnchor, left: folderButton.leftAnchor, bottom: folderButton.bottomAnchor, right: folderButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            folderIconImageView.alpha = 0
        }
        
        
    }
    
    
    func setupCameraButton() {
        let camerButtonInitialWidth: CGFloat = 107.57

        if cameraButton.isDescendant(of: self.view) {
            cameraButton.setImage(UIImage(named: "cameraLifting")?.withRenderingMode(.alwaysOriginal), for: .normal)
            cameraButton.frame = CGRect(x: view.frame.midX - camerButtonInitialWidth/2, y: customTabBar.frame.origin.y - 50, width: 107.57, height: 50.43)
        } else {
            view.addSubview(cameraButton)
            cameraButton.frame = CGRect(x: view.frame.midX - camerButtonInitialWidth/2, y: customTabBar.frame.origin.y - 5 - 50.43, width: 107.57, height: 50.43)
            cameraButton.addSubview(cameraIconImageView)
            cameraIconImageView.anchor(top: cameraButton.topAnchor, left: cameraButton.leftAnchor, bottom: cameraButton.bottomAnchor, right: cameraButton.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            cameraIconImageView.alpha = 0
        }
    }
    
    
 
    func hideButtons(left: Bool, right:Bool, center: Bool) {
        self.photoButton.isHidden = left
        self.folderButton.isHidden = right
        self.cameraButton.isHidden = center
    }
  
    @objc func plusButtonHeldDown() {
        self.bounceView.compressAnimation()
    }
    
    @objc func plusButtonLifted() {
        
        if !buttonsShowing {
            // buttons not on screen, animate in
            self.bounceView.expandToInitialHeightAnimation { (complete) in
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut) {
                    self.photoIconImageView.alpha = 1.0
                    self.folderIconImageView.alpha = 1.0
                }
                self.hideButtons(left: false, right: false, center: true)
                self.liftLeftAndRightButtons()
            }
        } else {
            // button on screen, animate out
            self.lowerSideButtons()
            self.bounceView.expandToInitialHeightAnimation { (complete) in
                
                self.setupLeftAndRightButtons()
                self.lowerCameraButton()
                self.bounceView.expandAnimation { (complete) in
                    self.finishLoweringCameraButton()
                    self.buttonsShowing = false
                }
            }
        }
    }
    
    func liftLeftAndRightButtons() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.photoButton.setImage(UIImage(named: "photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.folderButton.setImage(UIImage(named: "folder")?.withRenderingMode(.alwaysOriginal), for: .normal)

            self.photoButton.frame.origin.x = 63
            self.photoButton.frame.origin.y = self.customTabBar.frame.origin.y - 60
            self.photoButton.frame.size.width = 60
            self.photoButton.frame.size.height = 60

            self.folderButton.frame.origin.x = self.view.frame.size.width - (63*2)
            self.folderButton.frame.origin.y = self.customTabBar.frame.origin.y - 60
            self.folderButton.frame.size.width = 60
            self.folderButton.frame.size.height = 60
            
            print("CustomTabheight: \(self.customTabBar.frame.size.height)")
            let finalY = self.view.frame.size.height -  self.customTabBar.frame.size.height - 120
            
            self.bounceView.expandAnimation { (complete) in
                self.hideButtons(left: false, right: false, center: false)
                UIView.animate(withDuration: 0.12, delay: 0.1, options: .curveEaseOut) {
                    self.cameraIconImageView.alpha = 1.0
                }
                self.liftCameraButon()

            }
            UIView.animate(withDuration: 0.08, delay: 0.0, options: .curveEaseOut) {
                self.photoButton.frame.origin.y = finalY - 8
                self.folderButton.frame.origin.y = finalY - 8
            } completion: { (complete) in
                UIView.animate(withDuration: 0.06, delay: 0, options: .curveEaseOut) {
                    self.photoButton.frame.origin.y = finalY + 5
                    self.folderButton.frame.origin.y = finalY + 5
                } completion: { (completed) in
                    UIView.animate(withDuration: 0.04, delay: 0, options: .curveEaseOut) {
                        self.photoButton.frame.origin.y = finalY
                        self.folderButton.frame.origin.y = finalY
                    }
                    self.buttonsShowing = true
                }
            }
        }
    }
    
    func liftCameraButon() {
        // this animation needs to end at the same time as the left/right buttons
        // left/right buttons ends at 0.18
        // this starts at 0.03
        // anim should take 0.15
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
            
            self.cameraButton.setImage(UIImage(named: "camera")?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.cameraButton.frame.origin.x = self.view.frame.midX - (72/2)
            self.cameraButton.frame.origin.y = self.customTabBar.frame.origin.y - 72 - 5
            self.cameraButton.frame.size.width = 72
            self.cameraButton.frame.size.height = 72
            
            
            self.bounceView.expandAnimation { (complete) in
                self.hideButtons(left: false, right: false, center: false)
                self.bounceView.jiggleAnimation()
            }
            let leftRightButtonsY = self.view.frame.size.height -  self.customTabBar.frame.size.height - 120
            let finalY = leftRightButtonsY - ((72-60) / 2)

            UIView.animate(withDuration: 0.07, delay: 0.0, options: .curveEaseOut) {
                self.cameraButton.frame.origin.y = finalY - 8
                
            } completion: { (complete) in
                UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseOut) {
                    self.cameraButton.frame.origin.y = finalY + 5
                } completion: { (completed) in
                    UIView.animate(withDuration: 0.03, delay: 0, options: .curveEaseOut) {
                        self.cameraButton.frame.origin.y = finalY
                    }
                }
            }
        }
    }
    
 
    func lowerSideButtons() {
        self.photoIconImageView.alpha = 0
        self.folderIconImageView.alpha = 0

        UIView.animate(withDuration: 0.02, delay: 0.01, options: .curveEaseOut) {

            self.photoButton.frame.origin.y = self.customTabBar.frame.origin.y - 60
            self.folderButton.frame.origin.y = self.customTabBar.frame.origin.y - 60

        }
    }
    
    func lowerCameraButton() {
        self.cameraIconImageView.alpha = 0
        
        UIView.animate(withDuration: 0.02, delay: 0.01, options: .curveEaseOut) {
            self.cameraButton.frame.origin.y = self.customTabBar.frame.origin.y - 72 - 5
        } completion: { (complete) in
            self.cameraButton.setAttributes(isLifting: false)
            self.setupCameraButton()
        }
    }
    
    func finishLoweringCameraButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
            self.hideButtons(left: true, right: true, center: true)
            self.bounceView.jiggleAnimation()
        }
    }
    
}
