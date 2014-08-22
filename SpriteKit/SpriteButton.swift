//
//  SpriteButton.swift
//  
//
//  Created by Kevin Bi on 8/22/14.
//
//

import SpriteKit;

class SpriteButton : GameObject{
    let labelNode : SKLabelNode;
    var text : String;
    var onClick : (() -> Void)?;
    var touchedIn : Bool;
    
    override var center : CGPoint{
        get{return super.center;}
        set{
            super.center = newValue;
            labelNode.position = newValue;
        }
    }
    
    init(gameObject : GameObject, labelText : String?){
        labelNode = SKLabelNode(text: labelText!);
        text = labelText!;
        touchedIn = false;
        onClick = nil;
        super.init(source: gameObject);
        labelNode.color = UIColor.whiteColor();
        labelNode.text = labelText;
        labelNode.position = center;
    }
    
    func touchesBegan(touches : NSSet, event : UIEvent)->Void{
        var touch = (touches.allObjects.first) as? UITouch;
        if(contains(touch!.locationInNode(self.sprite.parent))){
            touchedIn = true;
        }
        else{
            touchedIn = false;
        }
    }
    
    func touchesEnded(touches : NSSet, even : UIEvent)->Void{
        var touch = (touches.allObjects.first) as? UITouch;
        if(touchedIn && contains(touch!.locationInNode(self.sprite.parent))){
            onClick!();
        }
        touchedIn = false;
    }
}