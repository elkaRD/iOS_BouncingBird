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
    private let colorManager : LevelColorManager;
    
    private var triangle : SKShapeNode = SKShapeNode()
    
    init(_ scene : SKScene,_ side : Bool, _ colorManager : LevelColorManager)
    {
        self.side = side;
        self.colorManager = colorManager;
        super.init(scene);
        
        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0.0, y: 50.0))
//        path.addLine(to: CGPoint(x: 50.0, y: -36.6))
//        path.addLine(to: CGPoint(x: -50.0, y: -36.6))
//        path.addLine(to: CGPoint(x: 0.0, y: 50.0))
        path.move(to: CGPoint(x: 0.0, y: 50.0))
        path.addLine(to: CGPoint(x: 60.0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: -50.0))
        path.addLine(to: CGPoint(x: -60, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 50))
        
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 20, y: 44))
//        path.addLine(to: CGPoint(x: 40, y: 0))
//        path.addLine(to: CGPoint(x: 0, y: 0))
        
        zPosition = -100;
        triangle = SKShapeNode(path: path.cgPath)
        triangle.fillColor = colorManager.getCurColor();
        addChild(triangle);
        
//        physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
//        physicsBody?.affectedByGravity = false;
//        //physicsBody?.isDynamic = false;        
//        physicsBody?.contactTestBitMask = GameScene.maskSpike;
        
        if side
        {
            triangle.position.x = -scene.frame.size.width / 2 + 15;
            //zRotation = -0.5;
        }
        else
        {
            triangle.position.x = scene.frame.size.width / 2 - 15;
            //zRotation = 0.5;
        }
        
        var startPos = triangle.position;
        let endPos = triangle.position;
        
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
        path.addLine(to: CGPoint(x: 60.0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: -50.0))
        path.addLine(to: CGPoint(x: -60, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 50))
        
        triangle.physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
        triangle.physicsBody?.affectedByGravity = false;
        //physicsBody?.isDynamic = false;
        //triangle.physicsBody?.contactTestBitMask = GameScene.maskSpike;
        triangle.physicsBody?.categoryBitMask = GameScene.maskSpike;
        triangle.physicsBody?.contactTestBitMask = GameScene.maskEverything;
        triangle.physicsBody?.collisionBitMask = 0;
        
        triangle.run(SKAction.colorize(with: UIColor.green, colorBlendFactor: 1, duration: 2));
    }
    
    public func runActionOnTriangle(_ action : SKAction)
    {
        triangle.run(action);
    }
}
