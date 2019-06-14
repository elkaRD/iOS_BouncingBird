//
//  Player.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 13/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player : GameObject
{
    private var velocity : Float = 150;
    private var direction : Bool = true;
    
    private var isAlive : Bool = true;
    
    override init(_ scene : SKScene)
    {
        super.init(scene);
        
        self.levelScene = scene;
        //sprite = SKSpriteNode(imageNamed: "Player.png");
        
        //levelScene!.addChild(self.sprite!)
        
        //self.physicsBody = SKPhysicsBody(texture: sprite!.texture!, size: CGSize(width: sprite!.size.width, height: sprite!.size.height));
        //self.physicsBody?.affectedByGravity = true;
        //self.physicsBody?.isDynamic = true;
        
        self.sprite = scene.childNode(withName: "//playerSprite") as? SKSpriteNode
        //addChild(self.sprite!.copy() as! SKNode)
        self.sprite?.move(toParent: self);
        //self.sprite = SKSpriteNode(fileNamed: "Player.png")
        
        //let xConstraint = SKConstraint.positionX(SKRange(constantValue: 195));
        //constraints = [xConstraint];
        
        //self.physicsBody.const
    }
    
    required init(coder nsCoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func update(_ delta : Float)
    {
        if !isAlive
        {
            return;
        }
        
        if (direction)
        {
            //sprite!.position.x += CGFloat(velocity * delta);
            position.x += CGFloat(velocity * delta);
        }
        else
        {
            //sprite!.position.x -= CGFloat(velocity * delta);
            position.x -= CGFloat(velocity * delta);
        }
        //print(sprite!.position.x);
    }
    
    public func jump()
    {
        if !isAlive
        {
            return;
        }
        
        self.sprite?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500));
    }
    
    public func onLeftEdge()
    {
        direction = true;
//        let rotateAction = SKAction.rotate(toAngle: .pi / 4, duration: 0.5)
//        sprite!.run(rotateAction)
        yRotation = 0
    }
    
    public func onRightEdge()
    {
        direction = false;
//        let rotateAction = SKAction.rotate(toAngle: 0, duration: 0.5)
//        sprite!.run(rotateAction)
        yRotation = .pi
    }
    
    public func onDeath()
    {
        isAlive = false;
        //sprite?.physicsBody?.affectedByGravity = false;
        sprite?.physicsBody?.restitution = 0.8;
        sprite?.physicsBody?.linearDamping = 0.1;
        sprite?.physicsBody?.angularDamping = 0.1;
    }
    
    public func getIsAlive() -> Bool
    {
        return isAlive;
    }
}
