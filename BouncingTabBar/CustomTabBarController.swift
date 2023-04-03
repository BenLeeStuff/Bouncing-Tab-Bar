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
        //setupMaskView()
        
        leftAndRightButtons(hidden: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupButtons()
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
       //plusButtonMask.addTarget(self, action: #selector(handlePlusPress), for: UIControl.Event.allTouchEvents)
        plusButtonMask.addTarget(self, action: #selector(plusButtonHeldDown), for: UIControl.Event.touchDown)
        plusButtonMask.addTarget(self, action: #selector(plusButtonLifted), for: UIControl.Event.touchUpInside)
    }
 
    func setupButtons() {
        view.addSubview(photoButton)
        //view.addSubview(cameraButton)
        view.addSubview(folderButton)
        
        
        photoButton.frame = CGRect(x: 61, y: customTabBar.frame.origin.y - 53, width: 65.8, height: 53)
        
        folderButton.frame = CGRect(x: view.frame.size.width - 122, y: customTabBar.frame.origin.y - 52.1, width: 65.8, height: 53)
        
    }
    
    func leftAndRightButtons(hidden: Bool) {
        if hidden {
            self.photoButton.isHidden = true
            self.folderButton.isHidden = true
        } else {
            self.photoButton.isHidden = false
            self.folderButton.isHidden = false
        }
    }
  
    
    @objc func plusButtonHeldDown() {
        self.bounceView.compressAnimation()
    }
    
    @objc func plusButtonLifted() {
        self.bounceView.compressToInitialHeightAnimation { (complete) in
            self.leftAndRightButtons(hidden: false)
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
            
            self.bounceView.expandAnimation()
            
            UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveEaseOut) {
                let finalY = self.view.frame.size.height -  self.customTabBar.frame.size.height - 120
                self.photoButton.frame.origin.y = finalY
                self.folderButton.frame.origin.y = finalY
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
