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
    private let scene : GameScene
    
    private let player : Player;
    private var leftSpikes = [Spike]();
    private var rightSpikes = [Spike]();
    private var gameObjects = [GameObject]();
    private var coin : Coin? = nil;
    
    private let spikesSlots : Int
    private let minSpikes : Int = 2;
    private let maxSpikes : Int;
    
    private var curScore : Int = 0;
    private var bestScore : Int = 0;
    
    private var direction : Bool = true;
    
    public init(_ scene : GameScene)
    {
        self.scene = scene;
        
        player = Player(scene);
        gameObjects.append(player);
        
        spikesSlots = Int(scene.size.height / Spike.length)
        maxSpikes = spikesSlots - 2;
        
        bestScore = GameLogic.loadBestScore();
        scene.setScore(curScore);
        
        generateSpikes();
    }
    
    public func update(_ delta : CGFloat)
    {
        for go in gameObjects
        {
            go.update(delta);
        }
        
        if player.position.x > 320 && direction
        {
            onRightEdge();
        }
        if player.position.x < -320 && !direction
        {
            onLeftEdge();
        }
    }
    
    public func jump()
    {
        player.jump()
    }
    
    public func onLeftEdge()
    {
        player.onLeftEdge();
        onBounce();
        generateSpikes(true, &leftSpikes);
        enableSpikes(&rightSpikes);
        direction = true;
    }
    
    public func onRightEdge()
    {
        player.onRightEdge();
        onBounce();
        generateSpikes(false, &rightSpikes);
        enableSpikes(&leftSpikes);
        direction = false;
    }
    
    public func onDeath()
    {
        if !player.getIsAlive()
        {
            return;
        }
        
        let newBest = curScore > bestScore
        
        player.onDeath();
        scene.onGameOver(bestScore, newBest);
        
        if newBest
        {
            saveBestScore();
        }
    }
    
    public func collectedCoin()
    {        
        coin?.onCollected();
    }
    
    private func onBounce()
    {
        if !player.getIsAlive()
        {
            return;
        }
        curScore = curScore + 1;
        
        scene.setScore(curScore);
        
        if coin == nil
        {
            coin = Coin(scene);
        }
    }
    
    private func enableSpikes(_ spikesArray : inout [Spike])
    {
        for spike in spikesArray
        {
            spike.enablePhycisc();
        }
    }
    
    private func generateSpikes()
    {
        generateSpikes(true, &leftSpikes);
        generateSpikes(false, &rightSpikes);
    }
    
    //private func generateSpikes(_ side : Bool)
    private func generateSpikes(_ side : Bool, _ spikesArray : inout [Spike])
    {
        //var spikesArray = leftSpikes
        
//        if !side
//        {
//            spikesArray = rightSpikes
//        }
        
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
            newSlots.remove(at: Int.random(newSlots.count));
        }
        
        for slotIndex in newSlots
        {
            var spike = Spike(scene, side);
            spike.position.y = Spike.length * CGFloat(slotIndex) - scene.frame.size.height / 2;
            spikesArray.append(spike);
        }
    }
    
    private func randSpikesNumber() -> Int
    {
        return Int.random(minSpikes, maxSpikes);
    }
    
    public func reachedHalfOfScreen()
    {
        
    }
    
    public static func loadBestScore() -> Int
    {
        if let score = UserDefaults.standard.object(forKey: "HighestScore")
        {
            return score as! Int;
        }
        
        return 0;
    }
    
    private func saveBestScore()
    {
        UserDefaults.standard.set(bestScore, forKey:"HighestScore")
        UserDefaults.standard.synchronize()
    }
}
