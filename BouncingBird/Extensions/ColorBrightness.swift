//
//  ColorBrightness.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 17/06/2019.
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
