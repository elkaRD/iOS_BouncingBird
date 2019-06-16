//
//  Coin.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 16/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class Coin : GameObject
{
    override init(_ scene : SKScene)
    {
        super.init(scene);
        
        let spriteToCopy = scene.childNode(withName: "//coinSprite") as? SKSpriteNode
        self.sprite = spriteToCopy?.copy() as! SKSpriteNode;
        self.sprite!.move(toParent: self);
        self.sprite?.position = CGPoint.zero;
        
        let rotationAction = SKAction.customAction(withDuration: 0.8)
        {
            node, elapsedTime in
            
            let s: CGFloat = elapsedTime / CGFloat(0.8);
            self.yRotation = CGFloat.lerpSin(0, 2 * .pi, s);
        }
        
        run(SKAction.repeatForever( SKAction.sequence([SKAction.wait(forDuration: 3.0), rotationAction])));
    }
    
    required init(coder nsCoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func onCollected()
    {
        let particles = SKEmitterNode(fileNamed: "ParticlesCollected.sks")
        particles?.position = sprite!.position;
        scene!.addChild(particles!)
    }
}
