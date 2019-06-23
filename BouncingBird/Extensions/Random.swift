//
//  Random.swift
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

public extension Int
{
    public static func random(_ minVal : Int, _ maxVal : Int) -> Int
    {
        return Int(arc4random_uniform(UInt32(maxVal - minVal))) + minVal;
    }
    
    public static func random(_ maxVal : Int) -> Int
    {
        return random(0, maxVal);
    }
}

public extension CGFloat
{
    public static func random(_ minVal : CGFloat, _ maxVal : CGFloat) -> CGFloat
    {
        let s = CGFloat(arc4random()) / CGFloat(UInt32.max);
        return (maxVal - minVal) * s + minVal;
    }
    
    public static func random(_ maxVal : CGFloat) -> CGFloat
    {
        return random(0, maxVal);
    }
}
