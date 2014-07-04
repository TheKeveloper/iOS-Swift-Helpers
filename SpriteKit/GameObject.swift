//
//  GameObject.swift
//  
//
//  Created by Kevin Bi on 7/3/14.
//
//

import SpriteKit

enum SpriteShape{
    case Circle, Rectangle;
}

class GameObject{
    let sprite : SKSpriteNode;
    var size: CGSize?{
    get{return sprite.size;}
    set{sprite.size = newValue!;}
    }
    var position : CGPoint?{
    get{return sprite.position;}
    set{sprite.position = newValue!;}
    }
    var shape : SpriteShape?;
    
    var speed : CGFloat = 0.0;
    var direction : CGPoint?{
    get{return self.direction}
    set{self.direction = CGPoint.normalize(newValue!)}
    }
    
    init(sprite: SKSpriteNode){
        self.sprite = sprite;
    }
    
    func move(){
        position = position! + (direction! * speed);
    }
}
