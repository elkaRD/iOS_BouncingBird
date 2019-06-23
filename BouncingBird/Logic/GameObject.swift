//
//  GameObject.swift
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

class GameObject : SKTransformNode
{
    internal var sprite : SKSpriteNode?;
    
    init(_ scene : SKScene)
    {
        super.init();
        
        scene.addChild(self)
    }
    
    required init(coder nsCoder : NSCoder)
    {
        super.init();
    }
    
    public func update(_ delta : CGFloat)
    {
        
    }
}
