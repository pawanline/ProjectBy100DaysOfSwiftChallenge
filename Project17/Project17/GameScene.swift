//
//  GameScene.swift
//  Project17
//
//  Created by Pawan Kumar on 05/04/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene ,SKPhysicsContactDelegate{
    
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel : SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var possibleEnemies = ["ball", "hammer", "tv"]
    var isGameOver = false
    var gameTimer: Timer?
    var timeInterval : Double = 1
      var count = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        if let node =  SKEmitterNode(fileNamed: "Starfield") {
            starfield = node
                starfield.position = CGPoint(x: 1024, y: 384)
            starfield.advanceSimulationTime(10)
            addChild(starfield)
            starfield.zPosition = -1
        }
        

        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
         score = 0
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
      
    }
    
    
    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isGameOver = true
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        explosion.particlePositionRange = CGVector(dx: 0.01, dy: 0.01)
        explosion.numParticlesToEmit = 3
        addChild(explosion)
        
        player.removeFromParent()
        
        isGameOver = true
    }
    
    override func update(_ currentTime: TimeInterval) {
      
        for node in children {
            print("node position is \(node.position.x)")
            if node.position.x < -100 {
             print("node position is removing")
                count += 1
                node.removeFromParent()
            }
        }
        
        if count >= 20 {
            gameTimer?.invalidate()
            gameTimer = Timer.scheduledTimer(timeInterval: timeInterval - 0.1, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            count = 0
        }
        
        
        
        if !isGameOver {
            score += 1
        }
    }
    
    

    
    
}
