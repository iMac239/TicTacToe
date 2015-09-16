//
//  CFPiece.swift
//  ConnectFour
//
//  Created by Ian MacCallum on 9/9/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class PlayerView: UIImageView {
    var player: Player? {
        didSet {
            if let player = player {
                alpha = 1
                switch player {
                case .X:
                    image = UIImage(named: "x")
                case .O:
                    image = UIImage(named: "o")
                }
            } else {
                alpha = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init() {
        super.init(frame: CGRectZero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        alpha = 0
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        layer.cornerRadius = frame.width / 2
    }
}