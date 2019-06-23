//
//  LevelColorManager.swift
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

class LevelColorManager
{
    private var nodes : [SKNode] = [];
    private var colors : [UIColor] = [];
    
    private var index : Int = 0;
    
    private let levelScene : SKScene;
    
    public init(_ scene : GameScene)
    {
        levelScene = scene;
        
        nodes.append((scene.childNode(withName: "//frameLeft"))!);
        nodes.append((scene.childNode(withName: "//frameRight"))!);
        nodes.append((scene.childNode(withName: "//frameTop"))!);
        nodes.append((scene.childNode(withName: "//frameBottom"))!);
        
        colors.append(UIColor.red);
        colors.append(UIColor.green);
        colors.append(UIColor.blue);
        colors.append(UIColor.brown);
        colors.append(UIColor.cyan);
        colors.append(UIColor.gray);
        colors.append(UIColor.orange);
        colors.append(UIColor.purple);
        colors.append(UIColor.yellow);
        colors.append(UIColor.white);
    }
    
    public func changeColor()
    {
        index += 1;
        index %= colors.count;
        let colorAction = SKAction.colorize(with: colors[index], colorBlendFactor: 1, duration: 2);

        for node in nodes
        {
            node.run(colorAction);
        }
        
        let backgroundColor = UIColor.mul(colors[index], 0.3);
        levelScene.run(SKAction.colorize(with: backgroundColor, colorBlendFactor: 1, duration: 2));
    }
    
    public func getCurColor() -> UIColor
    {
        return colors[index];
    }
    
    public func getNextColor() -> UIColor
    {
        var i = index + 1;
        i %= colors.count;
        return colors[i];
    }
}
