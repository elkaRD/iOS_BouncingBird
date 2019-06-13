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
    private var leftSpikes = [Spike]();
    private var rightSpikes = [Spike]();
    private var gameObjects = [GameObject]();
    
    private let spikesSlots : Int
    private let minSpikes : Int = 2;
    private let maxSpikes : Int;
    
    public init(_ scene : SKScene)
    {
        self.scene = scene;
        
        player = Player(scene);
        gameObjects.append(player);
        
        spikesSlots = Int(scene.size.height / Spike.length)
        maxSpikes = spikesSlots - 2;
        
        generateSpikes();
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
        generateSpikes(true);
        generateSpikes(false);
    }
    
    private func generateSpikes(_ side : Bool)
    {
        var spikesArray = leftSpikes
        
        if !side
        {
            spikesArray = rightSpikes
        }
        
        for spike in spikesArray
        {
            spike.hide()
        }
        
        spikesArray.removeAll();
        
        var newSpikesCount = randSpikesNumber();
        var newSlots : [Int] = Array()
        for i in 0...spikesSlots
        {
            newSlots.append(i);
        }
        
        for _ in 0...newSpikesCount
        {
            newSlots.remove(at: randomInt(newSlots.count));
        }
        
        for slotIndex in newSlots
        {
            var spike = Spike(scene, side);
            spike.position.y = Spike.length * CGFloat(slotIndex);
        }
    }
    
    private func randSpikesNumber() -> Int
    {
        return randomInt(minSpikes, maxSpikes);
    }
    
    private func randomInt(_ minVal : Int, _ maxVal : Int) -> Int
    {
        return Int(arc4random_uniform(UInt32(maxVal - minVal))) + minVal;
    }
    
    private func randomInt(_ maxVal : Int) -> Int
    {
        return randomInt(0, maxVal);
    }
}
