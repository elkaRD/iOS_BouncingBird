//
//  Coin.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 16/06/2019.
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

class Coin : GameObject
{
    override init(_ scene : SKScene)
    {
        super.init(scene);
        
        getAndInitSprite();
        initAnimation();
        initPosition();
    }
    
    required init(coder nsCoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func onCollected()
    {
        let particles = SKEmitterNode(fileNamed: "ParticlesCollected.sks")
        particles?.position = position;
        scene!.addChild(particles!)

        run(SKAction.sequence([SKAction.scale(to: 0, duration: 0.4), SKAction.removeFromParent()]))
    }
    
    private func getAndInitSprite()
    {
        let spriteToCopy = scene!.childNode(withName: "//coinSprite") as? SKSpriteNode
        self.sprite = spriteToCopy?.copy() as? SKSpriteNode;
        self.sprite!.move(toParent: self);
        self.sprite?.position = CGPoint.zero;
    }
    
    private func initAnimation()
    {
        let rotationAction = SKAction.customAction(withDuration: 0.8)
        {
            node, elapsedTime in
            
            let s: CGFloat = elapsedTime / CGFloat(0.8);
            self.yRotation = CGFloat.lerpSin(0, 2 * .pi, s);
        }
        
        let tempScale = xScale;
        setScale(0);
        run(SKAction.scale(to: tempScale, duration: 0.4));
        
        run(SKAction.repeatForever( SKAction.sequence([rotationAction, SKAction.wait(forDuration: 3.0)])));
    }
    
    private func initPosition()
    {
        position.x = CGFloat.random(-scene!.frame.size.width / 2 + 150, scene!.frame.size.width / 2 - 150);
        position.y = CGFloat.random(-scene!.frame.size.height / 2 + 100, scene!.frame.size.height / 2 - 100);
    }
}
