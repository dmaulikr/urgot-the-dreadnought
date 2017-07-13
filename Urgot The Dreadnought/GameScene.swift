//
//  GameScene.swift
//  Urgot The Dreadnought
//
//  Created by Avery Vine on 2017-07-12.
//  Copyright © 2017 Avery Vine. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "player")
    let floor = SKSpriteNode(imageNamed: "floor")
    
    var qButton: SKNode! = nil
    var eButton: SKNode! = nil
    
    override func didMove(to view: SKView) {
        
        for i in 0 ... 1 {
            let background = SKSpriteNode(imageNamed: "background")
            background.zPosition = -30
            background.anchorPoint = CGPoint.zero
            background.position = CGPoint(x: (background.size.width * CGFloat(i)) - CGFloat(1 * i), y: 0)
            addChild(background)
            
            let moveLeft = SKAction.moveBy(x: -background.size.width, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: background.size.width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            
            background.run(moveForever)
        }
        
        
        
        
        player.position = CGPoint(x: size.width * 0.1, y: (floor.size.height * 0.1) + (player.size.height * 0.5))
        floor.position = CGPoint(x: 0, y: 0 - floor.size.height * 0.4)
        
        addChild(player)
        
        addChild(floor)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(spawnMinion),
                SKAction.wait(forDuration: 1.0)
                ])
        ))
        
        let backgroundMusic = SKAudioNode(fileNamed: "background.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        qButton = SKSpriteNode(imageNamed: "qButton")
        eButton = SKSpriteNode(imageNamed: "eButton")
        
        qButton.position = CGPoint(x: qButton.frame.width * 0.5, y: size.height - qButton.frame.height * 0.5);
        eButton.position = CGPoint(x: size.width - eButton.frame.width * 0.5, y: size.height - eButton.frame.height * 0.5);
        
        addChild(qButton)
        addChild(eButton)
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func spawnMinion() {
        
        let minion = SKSpriteNode(imageNamed: "minion")

        minion.position = CGPoint(x: size.width + minion.size.width/2, y: (floor.size.height * 0.1) + (minion.size.height * 0.5))
        
        addChild(minion)
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        let actionMove = SKAction.move(to: CGPoint(x: -minion.size.width/2, y: (floor.size.height * 0.1) + (minion.size.height * 0.5)), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        minion.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            if qButton.contains(location) {
                print("q tapped!")
            }
            if eButton.contains(location) {
                print("e tapped!")
            }
        }
    }
}
