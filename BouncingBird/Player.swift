//
//  Player.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 13/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player : SKNode
{
    private var sprite : SKSpriteNode?;
    private var levelScene : SKScene?;
    
    init(_ scene : SKScene)
    {
        super.init();
        
        self.levelScene = scene;
        //sprite = SKSpriteNode(imageNamed: "Player.png");
        
        //levelScene!.addChild(self.sprite!)
        
        //self.physicsBody = SKPhysicsBody(texture: sprite!.texture!, size: CGSize(width: sprite!.size.width, height: sprite!.size.height));
        //self.physicsBody?.affectedByGravity = true;
        //self.physicsBody?.isDynamic = true;
        
        self.sprite = scene.childNode(withName: "//playerSprite") as? SKSpriteNode
    }
    
    required init(coder nsCoder : NSCoder)
    {
        super.init();
    }
    
    public func jump()
    {
        
    }
}
