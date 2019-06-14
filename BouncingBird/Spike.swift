//
//  Spike.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 13/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class Spike : GameObject
{
    public static let length : CGFloat = 200;
    
    private let side : Bool;
    
    init(_ scene : SKScene,_ side : Bool)
    {
        self.side = side;
        super.init(scene);
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 50.0))
        path.addLine(to: CGPoint(x: 50.0, y: -36.6))
        path.addLine(to: CGPoint(x: -50.0, y: -36.6))
        path.addLine(to: CGPoint(x: 0.0, y: 50.0))
        
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 20, y: 44))
//        path.addLine(to: CGPoint(x: 40, y: 0))
//        path.addLine(to: CGPoint(x: 0, y: 0))
        
        var triangle = SKShapeNode(path: path.cgPath)
        triangle.fillColor = UIColor.red;
        addChild(triangle);
        
        physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
        physicsBody?.affectedByGravity = false;
        physicsBody?.contactTestBitMask = GameScene.maskSpike;
        
        
        
        if side
        {
            position.x = -scene.frame.size.width / 2 + 50;
            zRotation = -0.5;
        }
        else
        {
            position.x = scene.frame.size.width / 2 - 50;
            zRotation = 0.5;
        }
        
        //scene.addChild(self);
    }
    
    required init(coder nsCoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func hide()
    {
        
    }
}
