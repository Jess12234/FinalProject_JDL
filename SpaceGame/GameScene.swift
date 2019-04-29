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
    
    var gametimer:Timer!
    var possibleAliens = ["alien1", "alien2", "alien3"]
    
    override func didMove(to view: SKView)
    {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x:0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "shuttle")
        
        player.position = CGPoint(x: 0, y: -600)
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy:0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: -200, y: 550)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        score = 0
        
        self.addChild(scoreLabel)
        
        gametimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        
    }
    
    @objc func addAlien()
    {
        possibleAliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as! [String]
        
        let alien = SKSpriteNode(imageNamed: possibleAliens[0])
        
        let randomAlienPosition = GKRandomDistribution(lowestValue: 0, hiestValue: 414)
        
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
