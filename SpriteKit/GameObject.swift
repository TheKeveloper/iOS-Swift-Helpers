//
//  GameObject.swift
//  
//
//  Created by Kevin Bi on 7/3/14.
//
//
//  ======== REQUIRES CGPoint_Extension.swift TO FUNCTION PROPERLY ========

import SpriteKit

enum SpriteShape{
    case Circle, Rectangle;
}

class GameObject{
    //Declarations
    let sprite : SKSpriteNode;
    var name : String = "";
    
    var size: CGSize{
    get{return sprite.size;}
    set{sprite.size = newValue;}
    }
    var width: CGFloat{
    get{return sprite.size.width}
    set{sprite.size.width = newValue}
    }
    var height: CGFloat{
    get{return sprite.size.height}
    set{sprite.size.height = newValue}
    }
    
    var position : CGPoint{
    get{return sprite.position}
    set(newValue){sprite.position = newValue}
    }
    //Shorter ways to access x and y of the position
    var x: CGFloat{
    get{return sprite.position.x}
    set{sprite.position.x = newValue}
    }
    var y: CGFloat{
    get{return sprite.position.y}
    set{sprite.position.y = newValue}
    }
    
    //Ways to access the y values of the top and bottom, and the x values of the left and right
    var top: CGFloat{
    get{return sprite.position.y + (sprite.size.height * sprite.anchorPoint.y)}
    set(newValue){sprite.position.y = newValue - (sprite.size.height * sprite.anchorPoint.y)}
    }
    var bottom: CGFloat{
    get{return sprite.position.y - (sprite.size.height * sprite.anchorPoint.y)}
    set(newValue){sprite.position.y = newValue + (sprite.size.height * sprite.anchorPoint.y)}
    }
    var left: CGFloat{
    get{return sprite.position.x - (sprite.size.width * sprite.anchorPoint.x)}
    set(newValue){sprite.position.x = newValue + (sprite.size.height * sprite.anchorPoint.x)}
    }
    var right: CGFloat{
    get{return sprite.position.x + (sprite.size.width * sprite.anchorPoint.x)}
    set(newValue){sprite.position.x = newValue - (sprite.size.width * sprite.anchorPoint.x)}
    }
    var center: CGPoint{
    get{return CGPoint(left + (size.width / 2), bottom + (size.height / 2))}
    set(newValue){
        sprite.position.x = newValue.x + (size.width * (0.5 - sprite.anchorPoint.x));
        sprite.position.y = newValue.y + (size.height * (0.5 - sprite.anchorPoint.y));
    }
    }
    
    var shape : SpriteShape?;
    
    var speed : CGFloat = 0.0;
    var direction : CGPoint?{
    get{return self.direction}
    set{self.direction = CGPoint.normalize(newValue!)}
    }
    
    var active = true;
    
    
    //Designated Initializer
    init(_ sprite: SKSpriteNode, size: CGSize, pos: CGPoint, speed: CGFloat, dir: CGPoint, shape: SpriteShape?){
        self.sprite = sprite;
        self.size = size;
        self.position = pos;
        self.speed = speed;
        self.shape = shape;
    }
    
    init(_ sprite: SKSpriteNode,_ size: CGSize,_ pos: CGPoint,_ speed: CGFloat,_ dir: CGPoint,_ shape: SpriteShape?){
        self.sprite = sprite;
        self.size = size;
        self.position = pos;
        self.speed = speed;
        self.shape = shape;
    }
    
    init(texture: SKTexture,_ size: CGSize,_ pos: CGPoint,_ speed: CGFloat,_ dir: CGPoint,_ shape: SpriteShape?){
        self.sprite = SKSpriteNode(texture: texture);
        self.size = size;
        self.position = pos;
        self.speed = speed;
        self.direction = dir;
        self.shape = shape;
    }
    //Convenience initializers
    convenience init(_ sprite: SKSpriteNode, size: CGSize, pos: CGPoint, speed: CGFloat, dir: CGPoint){
        self.init(sprite, size, pos, speed, dir, nil);
    }
    convenience init(_ sprite: SKSpriteNode, size: CGSize, pos: CGPoint){
        self.init(sprite, size, pos, 0, CGPoint.zeroPoint, nil);
    }
    convenience init(_ sprite: SKSpriteNode, size: CGSize){
        self.init(sprite, size, sprite.position, 0, CGPoint.zeroPoint, nil);
    }
    convenience init(_ sprite: SKSpriteNode){
        self.init(sprite, sprite.size, sprite.position, 0, CGPoint.zeroPoint, nil);
    }
    
    convenience init(texture: SKTexture, size: CGSize, pos: CGPoint, speed: CGFloat, dir: CGPoint){
        self.init(texture: texture, size, pos, speed, dir, nil);
    }
    convenience init(texture: SKTexture, size: CGSize, pos: CGPoint){
        self.init(texture: texture, size, pos, 0, CGPoint.zeroPoint, nil);
    }
    convenience init(texture: SKTexture, size: CGSize){
        self.init(texture: texture, size, CGPoint.zeroPoint, 0, CGPoint.zeroPoint, nil);
    }
    convenience init(texture: SKTexture){
        self.init(texture: texture, texture.size(), CGPoint.zeroPoint, 0, CGPoint.zeroPoint, nil);
    }
    
    //Methods
    func add(inout scene: SKScene)-> Void{
        scene.addChild(self.sprite);
    }
    func move()->Void {
        if(active){position += direction! * speed;}
    }
    
    func intersects(other: GameObject)-> Bool {
        let shapeA = self.shape? ? self.shape! : SpriteShape.Rectangle;
        let shapeB = other.shape? ? other.shape! : SpriteShape.Rectangle;
        
        if(shapeA == shapeB){
            if(shapeA == .Rectangle){
                return self.left <= other.right && self.right >= other.left && self.top >= other.bottom && self.bottom <= other.top;
            }
            else{
                var radA = size.width / 2;
                var radB = size.width / 2;
                var diffX = self.center.x - other.center.x;
                var diffY = self.center.y - other.center.y;
                return (diffX * diffX) + (diffY * diffY) <= (radA + radB) * (radA + radB);
            }
        }
        //Haven't figured out yet how to do Rect - Circle collision detection
        //Will implement later
        return false;
    }
    
    func contains(p: CGPoint)-> Bool{
        var shape = self.shape? ? self.shape! : SpriteShape.Rectangle;
        if(shape == .Rectangle){
            return p.x >= self.left && p.x <= self.right && p.y >= self.bottom && p.y <= self.top;
        }
        else{
            var diffX = p.x - self.position.x;
            var diffY = p.y - self.position.y;
            var rad = width / 2;
            return (diffX * diffX) + (diffY * diffY) <= rad * rad;
        }
    }
    
}
