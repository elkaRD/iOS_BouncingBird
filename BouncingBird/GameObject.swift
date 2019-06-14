//
//  GameObject.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 13/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameObject : SKTransformNode
{
    internal var sprite : SKSpriteNode?;
    internal var levelScene : SKScene?;
    
    init(_ scene : SKScene)
    {
        super.init();
        
        scene.addChild(self)
    }
    
    required init(coder nsCoder : NSCoder)
    {
        super.init();
    }
    
    public func update(_ delta : Float)
    {
        
    }
}
