//
//  Player.swift
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

class Player : GameObject
{
    private var velocity : CGFloat = 150;
    private var direction : Bool = true;
    
    private var isAlive : Bool = true;
    private var reachedHalfScreen : Bool = false;
    
    private let rotYDuration : CGFloat = 0.4;
    
    override init(_ scene : SKScene)
    {
        super.init(scene);
        
        self.sprite = scene.childNode(withName: "//playerSprite") as? SKSpriteNode
        self.sprite?.move(toParent: self);
    }
    
    required init(coder nsCoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func update(_ delta : CGFloat)
    {
        if !isAlive
        {
            return;
        }
        
        if (direction)
        {
            position.x += CGFloat(velocity * delta);
        }
        else
        {
            position.x -= CGFloat(velocity * delta);
        }
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
        
        SoundManager.playSound(self, SoundManager.SoundType.Swing);
    }
    
    public func onLeftEdge()
    {
        direction = true;
        onBounce();
    }
    
    public func onRightEdge()
    {
        direction = false;
        onBounce();
    }
    
    public func onDeath()
    {
        isAlive = false;
        
        sprite?.physicsBody?.restitution = 0.8;
        sprite?.physicsBody?.linearDamping = 0.1;
        sprite?.physicsBody?.angularDamping = 0.1;
        sprite?.physicsBody?.allowsRotation = true;
        sprite?.physicsBody?.applyAngularImpulse(1);
        
        SoundManager.playSound(self, SoundManager.SoundType.Crash);
        
        sprite?.run(SKAction.colorize(with: UIColor.black, colorBlendFactor: 0.5, duration: 1));
    }
    
    public func getIsAlive() -> Bool
    {
        return isAlive;
    }
    
    private func onBounce()
    {
        if !isAlive
        {
            return;
        }
        
        rotateAfterBounce();
        SoundManager.playSound(self, SoundManager.SoundType.Click);
    }
    
    private func rotateAfterBounce()
    {
        let rotationAction = SKAction.customAction(withDuration: TimeInterval(self.rotYDuration))
        {
            node, elapsedTime in
            
            let s: CGFloat = elapsedTime / CGFloat(self.rotYDuration);
            if self.direction
            {
                self.yRotation = CGFloat.lerpSin(0, .pi, s);
            }
            else
            {
                self.yRotation = CGFloat.lerpSin(.pi, 2 * .pi, s);
            }
        }
        
        run(rotationAction);
    }
}
