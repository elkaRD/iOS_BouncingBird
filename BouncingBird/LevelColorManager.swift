//
//  LevelColorManager.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 16/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

extension UIColor
{
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
    
    public static func mul(_ c : UIColor,_ s : CGFloat) -> UIColor
    {
        var r = c.redValue;
        var g = c.greenValue;
        var b = c.blueValue;
        let a = c.alphaValue;
        
        r *= s;
        g *= s;
        b *= s;
        
        return UIColor(red: r, green: g, blue: b, alpha: a);
    }
}

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
    
    public func addNode(_ node : SKNode)
    {
        nodes.append(node);
    }
    
//    public func removeNode(_ node : SKNode)
//    {
//        nodes.remove(node);
//    }
    
    public func changeColor(_ leftSpikes : inout [Spike], _ rightSpikes : inout [Spike])
    {
        index += 1;
        index %= colors.count;
        let colorAction = SKAction.colorize(with: colors[index], colorBlendFactor: 1, duration: 2);
        
        for spike in leftSpikes
        {
            spike.runActionOnTriangle(colorAction);
        }
        for spike in rightSpikes
        {
            spike.runActionOnTriangle(colorAction);
        }
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
