//
//  GameScene.swift
//  JumpGame
//
//  Created by user152290 on 4/3/19.
//  Copyright © 2019 user152290. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var landShark : SKSpriteNode?
    var gameTime : Timer?
    var ground : SKSpriteNode?
    var ceiling : SKSpriteNode?
    
    let landSharkCategory : UInt32 = 0x1 << 1
    let coinCategory : UInt32 = 0x1 << 2
    let explosionCategory : UInt32 = 0x1 << 3
    let groundAndCeilingCategory : UInt32 = 0x1 << 4
    
    var score = 0
    
    
    override func didMove(to view: SKView) {
        
        landShark = childNode(withName: "landShark") as? SKSpriteNode
        
        //Setup Time
        
        gameTime = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.generateCoin()
        })
        
        //Collision
        physicsWorld.contactDelegate = self
        
        landShark = childNode(withName: "landShark") as? SKSpriteNode
        landShark?.physicsBody?.categoryBitMask = landSharkCategory
        landShark?.physicsBody?.contactTestBitMask = coinCategory | explosionCategory
        landShark?.physicsBody?.collisionBitMask = groundAndCeilingCategory
        ground = childNode(withName: "ground") as? SKSpriteNode
        ceiling?.physicsBody?.categoryBitMask = groundAndCeilingCategory
        
        ceiling = childNode(withName: "ceiling") as? SKSpriteNode
        ceiling?.physicsBody?.categoryBitMask = groundAndCeilingCategory
        ground?.physicsBody?.collisionBitMask = landSharkCategory
        
        
        
        
        
    }
    /Users/user152290/Library/Autosave Information/firstapp/newfirstapp/First/viewcontroler/camaro/vehiclesfirst/vehiclesfirst/JumpGame/JumpGame/jumpgame/JumpGame/GameScene.swift
    /Users/user152290/Library/Autosave Information/firstapp/newfirstapp/First/viewcontroler/camaro/vehiclesfirst/vehiclesfirst/JumpGame/JumpGame/jumpgame/JumpGame/GameScene.swift
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered/Users/user152290/Library/Autosave Information/firstapp/newfirstapp/First/viewcontroler/camaro/vehiclesfirst/vehiclesfirst/JumpGame/JumpGame/jumpgame/JumpGame/GameScene.swift
        
        landShark?.physicsBody?.applyForce((CGVector(dx: 0, dy: 90)))
        
    }
    
    func generateCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.contactTestBitMask = coinCategory
        coin.physicsBody?.contactTestBitMask = landSharkCategory
        addChild(coin)
        
        //Setting height
        let maximumY = size.height / 2 - coin.size.height / 2
        let minumumY = size.height / 2 + coin.size.height / 2
        let range = maximumY - minumumY
        _ = maximumY - CGFloat(arc4random_uniform(UInt32(range)))
        
        //Setup variable to handle direction
        coin.position = CGPoint(x: size.width / 2 + coin.size.width / 2, y: 0)
        
        //set direction of coin and speed
        let moveLeft = SKAction.moveBy(x: size.width - coin.size.width, y: 0, duration: 2)
        coin.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
    }
    func didStart(_ contact: SKPhysicsContact){
        print("Collided")
    }
    
}



