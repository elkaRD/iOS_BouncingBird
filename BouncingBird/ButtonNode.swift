//
//  ButtonNode.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 12/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class ButtonNode : SKLabelNode
{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        text = "my new text"
    }
    
    
}
