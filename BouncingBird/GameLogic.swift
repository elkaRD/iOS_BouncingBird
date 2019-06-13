//
//  GameLogic.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 13/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameLogic
{
    private let scene : SKScene
    private let player : Player;
    private var gameObjects = [GameObject]();
    
    public init(_ scene : SKScene)
    {
        self.scene = scene;
        
        player = Player(scene);
        gameObjects.append(player);
    }
    
    public func update(_ delta : Float)
    {
        for go in gameObjects
        {
            go.update(delta);
        }
    }
    
    public func jump()
    {
        player.jump()
    }
    
    public func onLeftEdge()
    {
        player.onLeftEdge();
    }
    
    public func onRightEdge()
    {
        player.onRightEdge();
    }
    
    public func onDeath()
    {
        player.onDeath();
    }
    
    private func generateSpikes()
    {
        
    }
}
