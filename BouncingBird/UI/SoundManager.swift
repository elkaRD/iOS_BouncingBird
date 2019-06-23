//
//  SoundManager.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 24/06/2019.
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

class SoundManager
{
    private static let instance : SoundManager = SoundManager();
    private var sounds : [SoundType : SKAction] = [:];
    
    enum SoundType
    {
        case Swing
        case Crash
        case Coin
        case Click
    }
    
    private init()
    {
        sounds[SoundType.Swing] = SKAction.playSoundFileNamed("swing.flac", waitForCompletion: false);
        sounds[SoundType.Crash] = SKAction.playSoundFileNamed("crash.wav", waitForCompletion: false);
        sounds[SoundType.Coin] = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false);
        sounds[SoundType.Click] = SKAction.playSoundFileNamed("click.wav", waitForCompletion: false);
    }
    
    static func playSound(_ node : SKNode, _ soundType : SoundType)
    {
        return instance.playSound(node, soundType);
    }
    
    private func playSound(_ node : SKNode, _ soundType : SoundType)
    {
        if sounds[soundType] == nil
        {
            return;
        }
        
        node.run(sounds[soundType]!);
    }
}
