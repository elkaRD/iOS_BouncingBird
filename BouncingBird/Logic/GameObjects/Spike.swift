//
//  Spike.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 13/06/2019.
//  Copyright © 2019 Robert Dudzinski. All rights reserved.
//
//  EN: Project for 'Programming for Mobile Apple iOS and MacOS X' course
//      Warsaw University of Technology
//
//  PL: Projekt APIOS (Programowanie dla systemów: mobilnego iOS oraz MacOS X)
//      PW WEiTI 19L
//

import SpriteKit
import GameplayKit

class Spike : GameObject
{
    public static let length : CGFloat = 200;
    public static let realSizeX : CGFloat = 70;
    public static let realSizeY : CGFloat = 120;
    
    private let side : Bool;
    private let colorManager : LevelColorManager;
    
    private var triangle : SKShapeNode = SKShapeNode()
    
    private static var didInitPoints : Bool = false;
    private static var path : UIBezierPath = UIBezierPath();
    
    init(_ scene : SKScene, _ side : Bool, _ colorManager : LevelColorManager)
    {
        self.side = side;
        self.colorManager = colorManager;
        super.init(scene);
        
        if !Spike.didInitPoints
        {
            Spike.initPoints();
        }
        
        zPosition = -100;
        
        createTriangle();
        initTrianglePosition();
    }
    
    required init(coder nsCoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTriangle()
    {
        triangle = SKShapeNode(path: Spike.path.cgPath)
        triangle.fillColor = colorManager.getCurColor();
        addChild(triangle);
    }
    
    private func initTrianglePosition()
    {
        var endPos = triangle.position;
        
        if side
        {
            endPos.x = -scene!.frame.size.width / 2 + 50;
        }
        else
        {
            endPos.x = scene!.frame.size.width / 2 - 50;
        }
        
        var startPos = endPos;
        
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
    }
    
    private static func initPoints()
    {
        didInitPoints = true;
        
        path.move(to: CGPoint(x: 0.0, y: realSizeY/2))
        path.addLine(to: CGPoint(x: realSizeX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: -realSizeY/2))
        path.addLine(to: CGPoint(x: -realSizeX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: realSizeY/2))
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
        triangle.physicsBody = SKPhysicsBody(polygonFrom: Spike.path.cgPath)
        triangle.physicsBody?.affectedByGravity = false;
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
