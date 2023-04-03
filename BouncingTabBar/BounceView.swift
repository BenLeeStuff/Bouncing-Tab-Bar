//
//  BounceView.swift
//  BouncingTabBar
//
//  Created by Ben Lee on 3/29/23.
//

import UIKit

class BounceView: UIView {
    
    let shapeLayer = CAShapeLayer()
    let leftCircleShapeLayer = CAShapeLayer()
    let rightCircleShapeLayer = CAShapeLayer()
    let middleCircleShapeLayer = CAShapeLayer()
    let cornerRadius: CGFloat = 15
    let initialHeight: CGFloat = 128
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        leftAndRightCircles(isHidden: true)
        middleCircle(isHidden: true)
    }
    
    override func layoutSubviews() {
        setupShapeLayerAttributes()
        setupBouncePath()
        
    }
    
    
    func setupShapeLayerAttributes() {
        shapeLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(shapeLayer)
        leftCircleShapeLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(leftCircleShapeLayer)
        rightCircleShapeLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(rightCircleShapeLayer)
        middleCircleShapeLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(middleCircleShapeLayer)
    }
    
    func setupBouncePath() {
        shapeLayer.path = initialBouncePath().cgPath
        leftCircleShapeLayer.path = initialLeftCirclePath().cgPath
        rightCircleShapeLayer.path = initialRightCirclePath().cgPath
        middleCircleShapeLayer.path = initialMiddleCirclePath().cgPath
    }
    
    func leftAndRightCircles(isHidden: Bool) {
        if isHidden {
            self.leftCircleShapeLayer.isHidden = true
            self.rightCircleShapeLayer.isHidden = true
        } else {
            self.leftCircleShapeLayer.isHidden = false
            self.rightCircleShapeLayer.isHidden = false
        }
    }
    
    func middleCircle(isHidden: Bool) {
        if isHidden {
            self.middleCircleShapeLayer.isHidden = true
        } else {
            self.middleCircleShapeLayer.isHidden = false
        }
    }
    
//    func createBouncePath() -> UIBezierPath {
//        let path = UIBezierPath()
//
//        return path
//    }
    
    func initialBouncePath() -> UIBezierPath {
        let width = frame.maxX
        let initialY = frame.size.height - initialHeight
        let height: CGFloat = frame.size.height
        let path = UIBezierPath()
        print("initial y: \(initialY), maxY: \(frame.maxY), initialHeight: \(initialHeight)")

        //let p1 = CGPoint(x: width / 2, y: 0)//top center
        let p1 = CGPoint(x: width - cornerRadius, y: initialY) // top right quad start
        let controlPoint1 = CGPoint(x: width, y: initialY)
        let p2 = CGPoint(x: width, y: initialY + cornerRadius) // top right quad end
        let p3 = CGPoint(x: width, y: height)//bottom right
        let p4 = CGPoint(x: 0, y: height)//bottom left
        let p5 = CGPoint(x: 0, y: initialY + cornerRadius) // top left quad start
        let controlPoint2 = CGPoint(x: 0, y: initialY)
        let p6 = CGPoint(x: cornerRadius, y: initialY) // top left quad end

        path.move(to: p1)
        path.addQuadCurve(to: p2, controlPoint: controlPoint1)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.addLine(to: p5)
        path.addQuadCurve(to: p6, controlPoint: controlPoint2)
        path.close()
 
        return path
    }
    
    func compressedBouncePath() -> UIBezierPath {
        let width = frame.maxX
        let initialY = frame.size.height - initialHeight
        let height: CGFloat = frame.size.height

        let compressedHeight: CGFloat = frame.size.height - initialHeight + 19
        let path = UIBezierPath()
        let p1 = CGPoint(x: width - cornerRadius, y: initialY) // top right quad start
        let controlPoint1 = CGPoint(x: width, y: initialY)
        let p2 = CGPoint(x: width, y: initialY + cornerRadius) // top right quad end
        let p3 = CGPoint(x: width, y: height)//bottom right
        let p4 = CGPoint(x: 0, y: height)//bottom left
        let p5 = CGPoint(x: 0, y: initialY + cornerRadius) // top left quad start
        let controlPoint2 = CGPoint(x: 0, y: initialY)
        let p6 = CGPoint(x: cornerRadius, y: initialY) // top left quad end
        let controlPoint3 = CGPoint(x: width / 2, y: compressedHeight)
        
        path.move(to: p1)
        path.addQuadCurve(to: p2, controlPoint: controlPoint1)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.addLine(to: p5)
        path.addQuadCurve(to: p6, controlPoint: controlPoint2)
        path.addQuadCurve(to: p1, controlPoint: controlPoint3)
        path.close()
        return path
    }
    
    func compressedBouncePath2() -> UIBezierPath {
        let width = frame.maxX
        let initialY = frame.size.height - initialHeight
        let height: CGFloat = frame.size.height

        let compressedHeight: CGFloat = frame.size.height - initialHeight + 10
        let path = UIBezierPath()
        let p1 = CGPoint(x: width - cornerRadius, y: initialY) // top right quad start
        let controlPoint1 = CGPoint(x: width, y: initialY)
        let p2 = CGPoint(x: width, y: initialY + cornerRadius) // top right quad end
        let p3 = CGPoint(x: width, y: height)//bottom right
        let p4 = CGPoint(x: 0, y: height)//bottom left
        let p5 = CGPoint(x: 0, y: initialY + cornerRadius) // top left quad start
        let controlPoint2 = CGPoint(x: 0, y: initialY)
        let p6 = CGPoint(x: cornerRadius, y: initialY) // top left quad end
        let controlPoint3 = CGPoint(x: width / 2, y: compressedHeight)
        
        path.move(to: p1)
        path.addQuadCurve(to: p2, controlPoint: controlPoint1)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.addLine(to: p5)
        path.addQuadCurve(to: p6, controlPoint: controlPoint2)
        path.addQuadCurve(to: p1, controlPoint: controlPoint3)
        path.close()
        return path
    }
    
    
    
    func expandedBouncePath() -> UIBezierPath {
        let width = frame.maxX
        let initialY = frame.size.height - initialHeight
        let height: CGFloat = frame.size.height

        let expandedHeight: CGFloat = frame.size.height - initialHeight - 12
        let path = UIBezierPath()
        let p1 = CGPoint(x: width - cornerRadius, y: initialY) // top right quad start
        let controlPoint1 = CGPoint(x: width, y: initialY)
        let p2 = CGPoint(x: width, y: initialY + cornerRadius) // top right quad end
        let p3 = CGPoint(x: width, y: height)//bottom right
        let p4 = CGPoint(x: 0, y: height)//bottom left
        let p5 = CGPoint(x: 0, y: initialY + cornerRadius) // top left quad start
        let controlPoint2 = CGPoint(x: 0, y: initialY)
        let p6 = CGPoint(x: cornerRadius, y: initialY) // top left quad end
        let controlPoint3 = CGPoint(x: width / 2, y: expandedHeight)
        
        path.move(to: p1)
        path.addQuadCurve(to: p2, controlPoint: controlPoint1)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.addLine(to: p5)
        path.addQuadCurve(to: p6, controlPoint: controlPoint2)
        path.addQuadCurve(to: p1, controlPoint: controlPoint3)
        path.close()
        return path
    }
    
    func expandedBouncePath2() -> UIBezierPath {
        let width = frame.maxX
        let initialY = frame.size.height - initialHeight
        let height: CGFloat = frame.size.height

        let expandedHeight: CGFloat = frame.size.height - initialHeight - 10
        let path = UIBezierPath()
        let p1 = CGPoint(x: width - cornerRadius, y: initialY) // top right quad start
        let controlPoint1 = CGPoint(x: width, y: initialY)
        let p2 = CGPoint(x: width, y: initialY + cornerRadius) // top right quad end
        let p3 = CGPoint(x: width, y: height)//bottom right
        let p4 = CGPoint(x: 0, y: height)//bottom left
        let p5 = CGPoint(x: 0, y: initialY + cornerRadius) // top left quad start
        let controlPoint2 = CGPoint(x: 0, y: initialY)
        let p6 = CGPoint(x: cornerRadius, y: initialY) // top left quad end
        let controlPoint3 = CGPoint(x: width / 2, y: expandedHeight)
        
        path.move(to: p1)
        path.addQuadCurve(to: p2, controlPoint: controlPoint1)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.addLine(to: p5)
        path.addQuadCurve(to: p6, controlPoint: controlPoint2)
        path.addQuadCurve(to: p1, controlPoint: controlPoint3)
        path.close()
        return path
    }
    
    func initialLeftCirclePath() -> UIBezierPath {
        let width = frame.maxX
        let initialY = frame.size.height - initialHeight
        let radius: CGFloat = 30
        let circleCenterY = initialY - radius + 9
        let circleCenterX: CGFloat = 93
        let circleCenter = CGPoint(x: circleCenterX, y: circleCenterY)
        let path = UIBezierPath()
        
        let rightControlPoint = CGPoint(x: circleCenterX + radius - 5, y: initialY)
        let p1 = CGPoint(x: rightControlPoint.x + 5, y: initialY)
        let circleBottom = CGPoint(x: circleCenterX, y: initialY)
        
        let leftControlPoint = CGPoint(x: circleCenterX-radius+5, y: initialY)
        let p2 = CGPoint(x: leftControlPoint.x - 5, y: initialY)
        
        path.move(to: circleBottom)
        path.addArc(withCenter: circleCenter, radius: 30, startAngle: 3*Double.pi/2, endAngle: Double.pi/6, clockwise: true)
        path.addQuadCurve(to: p1, controlPoint: rightControlPoint)
        path.addLine(to: circleBottom)
        path.close()
        
        path.move(to: circleBottom)
        path.addArc(withCenter: circleCenter, radius: 30, startAngle: 3*Double.pi/2, endAngle: 5*Double.pi/6, clockwise: false)
        path.addQuadCurve(to: p2, controlPoint: leftControlPoint)
        path.close()

        return path
    }
    
    func initialRightCirclePath() -> UIBezierPath {
        let width = frame.maxX
        let initialY = frame.size.height - initialHeight
        let radius: CGFloat = 30
        let circleCenterY = initialY - radius + 9
        let circleCenterX: CGFloat = width - 93
        let circleCenter = CGPoint(x: circleCenterX, y: circleCenterY)
        let path = UIBezierPath()
        
        let rightControlPoint = CGPoint(x: circleCenterX + radius - 5, y: initialY)
        let p1 = CGPoint(x: rightControlPoint.x + 5, y: initialY)
        let circleBottom = CGPoint(x: circleCenterX, y: initialY)
        
        let leftControlPoint = CGPoint(x: circleCenterX-radius+5, y: initialY)
        let p2 = CGPoint(x: leftControlPoint.x - 5, y: initialY)
        
        path.move(to: circleBottom)
        path.addArc(withCenter: circleCenter, radius: 30, startAngle: 3*Double.pi/2, endAngle: Double.pi/6, clockwise: true)
        path.addQuadCurve(to: p1, controlPoint: rightControlPoint)
        path.addLine(to: circleBottom)
        path.close()
        
        path.move(to: circleBottom)
        path.addArc(withCenter: circleCenter, radius: 30, startAngle: 3*Double.pi/2, endAngle: 5*Double.pi/6, clockwise: false)
        path.addQuadCurve(to: p2, controlPoint: leftControlPoint)
        path.close()

        return path
    }
    
    func initialMiddleCirclePath() -> UIBezierPath {
        let width = frame.maxX
        let initialY = frame.size.height - initialHeight
        let radius: CGFloat = 36
        let circleCenterY = initialY - 22
        let circleCenterX: CGFloat = width/2
        let circleCenter = CGPoint(x: circleCenterX, y: circleCenterY)
        let path = UIBezierPath()
        path.addArc(withCenter: circleCenter, radius: radius, startAngle: Double.pi, endAngle: 2*Double.pi, clockwise: true)

        path.close()
        
        let leftP1 = CGPoint(x: circleCenterX - radius, y: circleCenterY)
        let leftP2 = CGPoint(x: leftP1.x - 13, y: circleCenterY + 13)
        let leftControlPoint = CGPoint(x: leftP1.x, y: leftP2.y)
        
        path.move(to: leftP1)
        path.addQuadCurve(to: leftP2, controlPoint: leftControlPoint)

        let rightP1 = CGPoint(x: circleCenterX + radius, y: circleCenterY)
        let rightP2 = CGPoint(x: rightP1.x + 13, y: circleCenterY + 13)
        let rightControlPoint = CGPoint(x: rightP1.x, y: rightP2.y)
        path.addLine(to: rightP2)
        path.addQuadCurve(to: rightP1, controlPoint: rightControlPoint)
        path.fill()
        path.close()
        return path
    }
    
    func compressAnimation() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            print("compress animation complete")
        }
        let duration: CFTimeInterval = 0.05
        let compressAnimation = CABasicAnimation(keyPath: "path")
        compressAnimation.duration = duration
        compressAnimation.fromValue = initialBouncePath().cgPath
        compressAnimation.toValue = compressedBouncePath().cgPath
        compressAnimation.fillMode = .forwards
        compressAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        compressAnimation.isRemovedOnCompletion = false
        shapeLayer.add(compressAnimation, forKey: "compress")
        CATransaction.commit()
    }
    
    func compressAnimation2() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            print("compress animation complete")
            
        }
        let duration: CFTimeInterval = 0.02
        let compressAnimation2 = CABasicAnimation(keyPath: "path")
        compressAnimation2.duration = duration
        compressAnimation2.fromValue = initialBouncePath().cgPath
        compressAnimation2.toValue = compressedBouncePath2().cgPath
        compressAnimation2.fillMode = .forwards
        compressAnimation2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        compressAnimation2.isRemovedOnCompletion = false
        shapeLayer.add(compressAnimation2, forKey: "compress2")
        CATransaction.commit()
    }
    
    func compressToInitialHeightAnimation(completed: ((Bool) -> Void)?) {

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completed?(true)
        }
        let duration: CFTimeInterval = 0.005
        let expandToInitialHeightAnimation = CABasicAnimation(keyPath: "path")
        expandToInitialHeightAnimation.duration = duration
        expandToInitialHeightAnimation.fromValue = compressedBouncePath().cgPath
        expandToInitialHeightAnimation.toValue = initialBouncePath().cgPath
        expandToInitialHeightAnimation.fillMode = .forwards
        expandToInitialHeightAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        expandToInitialHeightAnimation.isRemovedOnCompletion = false
        shapeLayer.add(expandToInitialHeightAnimation, forKey: "toInitialHeight")
        CATransaction.commit()
    }
    
    func expandAnimation() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            print("expand animation complete")
            //self.compressAnimation2()
        }
        let duration: CFTimeInterval = 0.008
        
        let expandAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.duration = duration
        expandAnimation.fromValue =  initialBouncePath().cgPath
        expandAnimation.toValue = expandedBouncePath().cgPath
        expandAnimation.fillMode = .forwards
        expandAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        expandAnimation.isRemovedOnCompletion = false
        shapeLayer.add(expandAnimation, forKey: "expand")
        CATransaction.commit()
    }
    
    func expandAnimation2() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            print("expand animation complete")
            //self.expandToInitialHeightAnimation()
        }
        let duration: CFTimeInterval = 0.02
        
        let expandAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.duration = duration
        expandAnimation.fromValue = compressedBouncePath2().cgPath
        expandAnimation.toValue = expandedBouncePath2().cgPath
        expandAnimation.fillMode = .forwards
        expandAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        expandAnimation.isRemovedOnCompletion = false
        shapeLayer.add(expandAnimation, forKey: "expand")
        CATransaction.commit()
    }
    
//    func leftAndRightCirclesPath() -> UIBezierPath {
//        let path = initialBouncePath()
//        path.append(initialLeftCirclePath())
//        path.append(initialRightCirclePath())
//        return path
//    }
    
//    func showLeftAndRightCirclesAnimation() {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock {
//            print("expand to initial height animation complete")
//            //self.expandAnimation()
//        }
//        let duration: CFTimeInterval = 0.02
//        let showLeftAndRightCirclesAnimation = CABasicAnimation(keyPath: "path")
//        showLeftAndRightCirclesAnimation.duration = duration
//        showLeftAndRightCirclesAnimation.fromValue = compressedBouncePath().cgPath
//        showLeftAndRightCirclesAnimation.toValue = leftAndRightCirclesPath().cgPath
//        showLeftAndRightCirclesAnimation.fillMode = .forwards
//        showLeftAndRightCirclesAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
//        showLeftAndRightCirclesAnimation.isRemovedOnCompletion = false
//        shapeLayer.add(showLeftAndRightCirclesAnimation, forKey: "show left and right circles")
//        CATransaction.commit()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
