//
//  CFBoardView.swift
//  ConnectFour
//
//  Created by Ian MacCallum on 9/9/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit


class BoardView: UIView {
    
    var logic: Logic! = Logic()
    var views: [[PlayerView?]]! = [[]]
    var lines: [CAShapeLayer?] = []
    var addedPieceBlock: ((player: Player, location: Location) -> (Void))?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        reset()
        
        addedPieceBlock = { (player, location) in
            views[location.x][location.y]?.player = player
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
        addGestureRecognizer(tapGesture)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set view frames
        let side = frame.width / CGFloat(logic.rows)
        let size = CGSize(width: side, height: side)

        for i in 0..<logic.rows {
            for j in 0..<logic.rows {
                let origin = CGPoint(x: CGFloat(i) * size.width, y: CGFloat(j) * size.height)
                let frame = CGRect(origin: origin, size: size)
                views[i][j]?.frame = frame
            }
        }
        
        // Set line frames
        let width: CGFloat = 8
        
        lines[0]?.path = UIBezierPath(rect: CGRect(x: side - width / 2, y: 0, width: width, height: frame.height)).CGPath
        lines[1]?.path = UIBezierPath(rect: CGRect(x: 2 * side - width / 2, y: 0, width: width, height: frame.height)).CGPath
        lines[2]?.path = UIBezierPath(rect: CGRect(x: 0, y: side - width / 2, width: frame.width, height: width)).CGPath
        lines[3]?.path = UIBezierPath(rect: CGRect(x: 0, y: 2 * side - width / 2, width: frame.width, height: width)).CGPath

    }
    
    func handleTapGesture(gesture: UITapGestureRecognizer) {
        let x = Int(floor(gesture.locationInView(self).x / (frame.width / CGFloat(logic.columns))))
        let y = Int(floor(gesture.locationInView(self).y / (frame.height / CGFloat(logic.rows))))
        logic.addMark(atLocation: (x,y))
    }
    
    func reset() {
        
        logic.reset()
        
        // Setup Views
        views.flatMap({ return $0 }).forEach { $0?.removeFromSuperview() }
        views = [[PlayerView?]](count: logic.columns, repeatedValue: [PlayerView?](count: logic.rows, repeatedValue: nil))
        
        for i in 0..<logic.columns {
            for j in 0..<logic.rows {
                let item = PlayerView()
                addSubview(item)
                views[i][j] = item
            }
        }

        // Setup Lines
        lines.flatMap({ return $0 }).forEach { $0.removeFromSuperlayer() }
        lines = [CAShapeLayer?](count: 4, repeatedValue: nil)
        
        for i in 0..<4 {
            let line = CAShapeLayer()
            layer.addSublayer(line)
            lines[i] = line
        }
    }
}

