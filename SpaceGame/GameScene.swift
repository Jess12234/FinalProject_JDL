//
//  GameScene.swift
//  SpaceGame
//
//  Created by Jessica Lowry on 4/17/19.
//  Copyright © 2019 Jessica Lowry. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var starfield:SKEmitterNode!
    var player:SKSpriteNode!
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0{
    didSet {
        scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView)
    {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x:0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "shuttle")
        
        player.position = CGPoint(x: self.frame.size.width / 2, y: player.size.height / 2 + 20)
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy:0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 100, y:self.frame.size.height - 60)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        score = 0
        
        self.addChild(scoreLabel)
        
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
