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
    var possibleAliens = ["alien", "alien2", "alien3"]
    
    let alienCategory:UInt32 = 0x1 << 1
    let photonTorpedoCategory:UInt32 = 0x1 << 0
    
    
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
        
        let randomAlienPosition = GKRandomDistribution(lowestValue: 0, highestValue: 414)
        let position = CGFloat(randomAlienPosition.nextInt())
        
        alien.position = CGPoint(x: position - 200, y: 550)
        
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = photonTorpedoCategory
        alien.physicsBody?.collisionBitMask = 0
        
        self.addChild(alien)
        
        let animationDuration:TimeInterval = 10
        
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: position - 200 , y: -600), duration: animationDuration))
        
        actionArray.append(SKAction.removeFromParent())
        
        alien.run(SKAction.sequence(actionArray))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireTorpedo()
    }
    
    
    
    func fireTorpedo()
    {
        self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
        let torpedoNode = SKSpriteNode(imageNamed: "torpedo")
        torpedoNode.position = player.position
        torpedoNode.position.y += 5
        
        torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width / 2)
        torpedoNode.physicsBody?.isDynamic = true
        
        torpedoNode.physicsBody?.categoryBitMask = photonTorpedoCategory
        torpedoNode.physicsBody?.contactTestBitMask = alienCategory
        torpedoNode.physicsBody?.collisionBitMask = 0
        torpedoNode.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(torpedoNode)
        
        let animationDuration:TimeInterval = 1
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x , y: self.frame.size.height + 10), duration: animationDuration))
        
        actionArray.append(SKAction.removeFromParent())
        
        torpedoNode.run(SKAction.sequence(actionArray))
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & photonTorpedoCategory) != 0 && (secondBody.categoryBitMask & alienCategory) != 0 {
            torpedoDidCollideWithAlien(torpedo: firstBody.node as! SKSpriteNode , alien: secondBody.node as! SKSpriteNode)
        }
    }
    
    func torpedoDidCollideWithAlien (torpedo: SKSpriteNode, alien:SKSpriteNode)
    {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
