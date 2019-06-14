//
//  GameScene.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 12/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    private var gameLogic : GameLogic?
    
    private var lastUpdateTimeInterval: CFTimeInterval?
    private var minTimeInterval: CFTimeInterval = 0;
    
    public static let maskPlayer : UInt32 = 2;
    public static let maskRightEdge : UInt32 = 4;
    public static let maskLeftEdge : UInt32 = 8;
    public static let maskSpike : UInt32 = 16;
    
    override func sceneDidLoad()
    {
        physicsWorld.gravity = CGVector(dx: 0, dy: -9)
        gameLogic = GameLogic(self);
        
        let physicsBody = SKPhysicsBody (edgeLoopFrom: self.frame)
        self.physicsBody = physicsBody
        
//        var triangle = SKShapeNode()
        
//        triangle.path = path.cgPath
//        triangle.lineWidth = 10.0
//        triangle.strokeColor = UIColor.green
        
        print(frame.size.width)
        print(frame.size.height)
        
        
        
        Spike(self, true);
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        //self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // set as delegate:
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        gameLogic!.jump();
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        if (gameLogic == nil)
        {
            return;
        }
        
        var delta: CFTimeInterval = currentTime // no reason to make it optional
        if let luti = lastUpdateTimeInterval {
            delta = currentTime - luti
        }
        
        lastUpdateTimeInterval = currentTime
        
        if delta > 1.0 {
            delta = minTimeInterval
            // this line is redundant lastUpdateTimeInterval = currentTime
        }
        
        gameLogic!.update(Float(delta));
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        var a = contact.bodyA;
        
        if a == nil
        {
            return;
        }
        
        if a.node == nil
        {
            return ;
        }
        
        if a.node?.name == nil
        {
            return ;
        }
        
        print ("didBegin: " + String(a.contactTestBitMask));
        
        var bodyA = contact.bodyA;
        var bodyB = contact.bodyB;
        
        if (bodyA.contactTestBitMask & GameScene.maskPlayer) == 0
        {
            swap(&bodyA, &bodyB);
        }
        
        if (bodyA.contactTestBitMask & GameScene.maskPlayer) != 0
        {
            if (bodyB.contactTestBitMask & GameScene.maskLeftEdge) != 0
            {
                gameLogic?.onLeftEdge();
            }
            else if (bodyB.contactTestBitMask & GameScene.maskRightEdge) != 0
            {
                gameLogic?.onRightEdge();
            }
            else if (bodyB.contactTestBitMask & GameScene.maskSpike) != 0
            {
                gameLogic?.onDeath();
            }
        }
    }
}
