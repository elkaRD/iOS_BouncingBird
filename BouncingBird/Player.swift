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
    private var velocity : CGFloat = 150;
    private var direction : Bool = true;
    
    private var isAlive : Bool = true;
    private var reachedHalfScreen : Bool = false;
    
    private var rotYChanging : Bool = false;
    private let rotYDuration : CGFloat = 0.4;
    private var rotYTime : CGFloat = 0;
    
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
    
    public override func update(_ delta : CGFloat)
    {
        if rotYChanging
        {
            rotYTime = rotYTime + delta;
            
            var s = rotYTime / rotYDuration;
            if (s > 1)
            {
                s = 1;
                rotYChanging = false;
            }
            
            if direction
            {
                yRotation = CGFloat.lerpSin(0, .pi, s);
            }
            else
            {
                yRotation = CGFloat.lerpSin(.pi, 2 * .pi, s);
            }
            
            print(CGFloat.lerp(0, .pi, s));
        }
        
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
        
//        if !reachedHalfScreen && ((direction && position.x > 0) || (!direction && position.x < 0))
//        {
//            //gameLogic.reachedHalfOfScreen();
//        }

        
    }
    
    public func jump()
    {
        if !isAlive
        {
            return;
        }
        
        self.sprite?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500));
        
        let particles = SKEmitterNode(fileNamed: "ParticlesDrops.sks")
        particles?.position.y = sprite!.position.y;
        particles?.position.x = position.x;
        scene!.addChild(particles!)
        
        particles?.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.removeFromParent()
                ]))
    }
    
    public func onLeftEdge()
    {
        direction = true;
//        let rotateAction = SKAction.rotate(toAngle: .pi / 4, duration: 0.5)
//        sprite!.run(rotateAction)
        //yRotation = 0
        rotateAfterBounce();
    }
    
    public func onRightEdge()
    {
        direction = false;
//        let rotateAction = SKAction.rotate(toAngle: 0, duration: 0.5)
//        sprite!.run(rotateAction)
        //yRotation = .pi
        rotateAfterBounce();
    }
    
    public func onDeath()
    {
        isAlive = false;
        //sprite?.physicsBody?.affectedByGravity = false;
        sprite?.physicsBody?.restitution = 0.8;
        sprite?.physicsBody?.linearDamping = 0.1;
        sprite?.physicsBody?.angularDamping = 0.1;
        sprite?.physicsBody?.allowsRotation = true;
        
        sprite?.physicsBody?.applyAngularImpulse(1);
    }
    
    public func getIsAlive() -> Bool
    {
        return isAlive;
    }
    
    private func rotateAfterBounce()
    {
        if !isAlive
        {
            return;
        }
        
        rotYChanging = true;
        rotYTime = 0;
    }
}
