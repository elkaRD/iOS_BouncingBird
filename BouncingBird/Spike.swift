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
    
    private var triangle : SKShapeNode = SKShapeNode()
    
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
        
        triangle = SKShapeNode(path: path.cgPath)
        triangle.fillColor = UIColor.red;
        addChild(triangle);
        
//        physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
//        physicsBody?.affectedByGravity = false;
//        physicsBody?.contactTestBitMask = GameScene.maskSpike;
        
        if side
        {
            position.x = -scene.frame.size.width / 2;
            zRotation = -0.5;
        }
        else
        {
            position.x = scene.frame.size.width / 2;
            zRotation = 0.5;
        }
        
        var startPos = triangle.position;
        var endPos = triangle.position;
        
        if side
        {
            startPos.x -= 150;
        }
        else
        {
            startPos.x += 150;
        }
        
        triangle.position = startPos;
        triangle.run(SKAction.move(to: endPos, duration: 0.5))
        
        //scene.addChild(self);
    }
    
    required init(coder nsCoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func hide()
    {
        var endPos = triangle.position;
        
        if side
        {
            endPos.x -= 150;
        }
        else
        {
            endPos.x += 150;
        }
        
        triangle.run(SKAction.move(to: endPos, duration: 0.5))
        run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.removeFromParent()]))
    }
    
    public func enablePhycisc()
    {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 50.0))
        path.addLine(to: CGPoint(x: 50.0, y: -36.6))
        path.addLine(to: CGPoint(x: -50.0, y: -36.6))
        path.addLine(to: CGPoint(x: 0.0, y: 50.0))
        
        physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
        physicsBody?.affectedByGravity = false;
        physicsBody?.contactTestBitMask = GameScene.maskSpike;
    }
}
