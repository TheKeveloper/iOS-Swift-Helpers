//
//  CGSize_Extension.swift
//
//  Created by Kevin Bi on 7/4/14.
//  Copyright (c) 2014 Kevelopment. All rights reserved.
//

import Foundation
import UIKit

class ScreenSize{
    class func width()->Float{
        return Float(UIScreen.mainScreen().bounds.size.width);
    }
    
    class func height()->Float{
        return Float(UIScreen.mainScreen().bounds.size.height);
    }
    
    class func pctWidth(percent: Float)-> Float{
        return width() * (percent / 100);
    }
    
    class func pctHeight(percent: Float)-> Float{
        return height() * (percent / 100);
    }
    
    class func pct(width: Float, height: Float)-> CGPoint{
        return CGPoint(CGFloat(ScreenSize.width() * (width / 100)), CGFloat(ScreenSize.height() * (height / 100)));
    }
}
