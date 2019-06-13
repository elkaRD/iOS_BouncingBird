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
        //        if let label = self.label {
        //            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        //        }
        //
        //        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
//        let gameSceneTemp = GameScene(fileNamed: "GameScene");
//        self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fade(withDuration: 1.0));
        
        //var t = self.text;
        text = "my new text"
    }
    
    
}
