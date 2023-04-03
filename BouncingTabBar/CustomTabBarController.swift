//
//  CustomTabBarController.swift
//  BouncingTabBar
//
//  Created by Ben Lee on 3/29/23.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
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
        return b
    }()
    
    let cameraButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "cameraLifting")?.withRenderingMode(.alwaysOriginal), for: .normal)
        b.contentMode = .scaleAspectFit

        return b
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
        self.delegate = self
        customTabBar.delegate = self
        //maskTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        setupBounceView()
        setupCustomTabBar()
        setupPlusButtonMask()
        
        //hideButtons(left: true, right: true, center: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupLeftAndRightButtons()
        setupCameraButton()
        hideButtons(left: true, right: true, center: true)
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
        view.addSubview(photoButton)
        view.addSubview(folderButton)
        
        photoButton.frame = CGRect(x: 61, y: customTabBar.frame.origin.y - 53, width: 65.8, height: 53)
        folderButton.frame = CGRect(x: view.frame.size.width - 122, y: customTabBar.frame.origin.y - 52.1, width: 65.8, height: 53)
    }
    
    func setupCameraButton() {
        view.addSubview(cameraButton)
        let camerButtonInitialWidth: CGFloat = 107.57
        cameraButton.frame = CGRect(x: view.frame.midX - camerButtonInitialWidth/2, y: customTabBar.frame.origin.y - 5 - 50.43, width: 107.57, height: 50.43)
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
        self.bounceView.expandToInitialHeightAnimation { (complete) in
            self.hideButtons(left: false, right: false, center: true)
            self.liftLeftAndRightButtons()
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
            let jiggleDurations: [TimeInterval] = [0.08, 0.06, 0.04]
            
            self.bounceView.expandAnimation { (complete) in
                self.hideButtons(left: false, right: false, center: false)
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
    
    
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if item.tag == 1 {
//            print("selected center")
//            self.bounceView.compressAnimation()
//        }
//
//    }
    
}
