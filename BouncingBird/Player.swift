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
            sprite!.position.x += CGFloat(velocity * delta);
        }
        else
        {
            sprite!.position.x -= CGFloat(velocity * delta);
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
    }
    
    public func onRightEdge()
    {
        direction = false;
    }
    
    public func onDeath()
    {
        isAlive = false;
    }
}
