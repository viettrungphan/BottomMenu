//
//  BottomMenuView.swift
//  BottomMenu
//
//  Created by Trung Phan on 6/28/19.
//  Copyright © 2019 Dwarvesf. All rights reserved.
//

import UIKit

class BottomMenuView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var panView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    enum PanDirection {
        case up
        case down
    }
    
    //MARK: - Variables
    var screenHeight: CGFloat = 300
    var expandedHeight: CGFloat {
        return 4/5 * screenHeight
    }
    var halfExpandedHeight: CGFloat {
        return expandedHeight/2.0
    }
    
    var collapsedHeight: CGFloat = 50.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        validateLayout(direction: .down, viewHeight: collapsedHeight)
    }
    
    private func setupUI() {
        //Add pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panView.addGestureRecognizer(panGesture)
        
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        //Lookup position in super view
        let currenPanLocationY = sender.location(in: self.superview).y
        //Determine pan direction base on velocity
        let panDirection:PanDirection = sender.velocity(in: panView).y > 0 ? .down : .up
        //Fingueout height of menu base on currenPanLocationY
        let updateBottomHeight = screenHeight - currenPanLocationY
        
        // If user  dragging => update follow user finger
        if sender.state == .changed {
            self.bottomConstraint.constant = updateBottomHeight
        }
        
        //If user end drag, determine menu state base on current position and pan direction
        if sender.state == .ended {
            validateLayout(direction: panDirection, viewHeight: updateBottomHeight)
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: [.layoutSubviews], animations: {
            self.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func validateLayout(direction: PanDirection, viewHeight: CGFloat) {
        switch viewHeight {
        case ...halfExpandedHeight:
            if direction == .up {
                self.bottomConstraint.constant = halfExpandedHeight
            }else {
                self.bottomConstraint.constant = collapsedHeight
            }
        case halfExpandedHeight...:
            if direction == .up {
                self.bottomConstraint.constant = expandedHeight
            }else {
                self.bottomConstraint.constant = halfExpandedHeight
            }
        default:
            print("Default")
        }
        
        
    }
}
