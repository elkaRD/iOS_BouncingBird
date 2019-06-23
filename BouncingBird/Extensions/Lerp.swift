//
//  Lerp.swift
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

public extension CGFloat
{
    public static func lerp(_ beg : CGFloat, _ end : CGFloat, _ s: CGFloat) -> CGFloat
    {
        return (end - beg) * s + beg;
    }

    public static func lerpSin(_ beg : CGFloat, _ end : CGFloat, _ s : CGFloat) -> CGFloat
    {
        let t = (sin(s * .pi + .pi / 2) + 1) / 2;
        return (end - beg) * t + beg;
    }
}
