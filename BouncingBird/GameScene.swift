//
//  GameScene.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 12/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    
    private var scoreLabel : SKLabelNode?
    private var gameOverLabel : SKLabelNode?
    private var bestScoreLabel : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    private var gameLogic : GameLogic?
    
    private var lastUpdateTimeInterval: CFTimeInterval?
    private var minTimeInterval: CFTimeInterval = 0;
    
    public static let maskPlayer : UInt32 = 2;
    public static let maskRightEdge : UInt32 = 4;
    public static let maskLeftEdge : UInt32 = 8;
    public static let maskSpike : UInt32 = 16;
    public static let maskCoin : UInt32 = 32;
    
    override func sceneDidLoad()
    {
        physicsWorld.gravity = CGVector(dx: 0, dy: -9)
        gameLogic = GameLogic(self);
        
        let physicsBody = SKPhysicsBody (edgeLoopFrom: self.frame)
        self.physicsBody = physicsBody
        
//        var triangle = SKShapeNode()
        
//        triangle.path = path.cgPath
//        triangle.lineWidth = 10.0
//        triangle.strokeColor = UIColor.green
        
        print(frame.size.width)
        print(frame.size.height)
        
        
        //Spike(self, true);
        //Coin(self);
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // Get label node from scene and store it for use later
        self.scoreLabel = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.scoreLabel {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.gameOverLabel = self.childNode(withName: "//gameOverLabel") as? SKLabelNode
        self.bestScoreLabel = self.childNode(withName: "//bestScoreLabel") as? SKLabelNode
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        //self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // set as delegate:
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.scoreLabel {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        gameLogic!.jump();
        
        for touch in touches
        {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "playAgainButton"
            {
                let gameSceneTemp = GameScene(fileNamed: "GameScene");
                gameSceneTemp!.scaleMode = .aspectFill
                self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fade(withDuration: 1.0));
            }
            else if touchedNode.name == "returnButton"
            {
                let gameSceneTemp = MainMenuScene(fileNamed: "MainMenuScene");
                gameSceneTemp!.scaleMode = .aspectFill
                self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fade(withDuration: 1.0));
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        if (gameLogic == nil)
        {
            return;
        }
        
        var delta: CFTimeInterval = currentTime // no reason to make it optional
        if let luti = lastUpdateTimeInterval {
            delta = currentTime - luti
        }
        
        lastUpdateTimeInterval = currentTime
        
        if delta > 1.0 {
            delta = minTimeInterval
            // this line is redundant lastUpdateTimeInterval = currentTime
        }
        
        gameLogic!.update(CGFloat(delta));
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
//        var a = contact.bodyA;
//
//        if a == nil
//        {
//            return;
//        }
//
//        if a.node == nil
//        {
//            return ;
//        }
//
//        if a.node?.name == nil
//        {
//            return ;
//        }
//
//        print ("didBegin: " + String(a.contactTestBitMask));
        
        var bodyA = contact.bodyA;
        var bodyB = contact.bodyB;
        
        if (bodyA.contactTestBitMask & GameScene.maskPlayer) == 0
        {
            swap(&bodyA, &bodyB);
        }
        
        if (bodyA.contactTestBitMask & GameScene.maskPlayer) != 0
        {
//            if (bodyB.contactTestBitMask & GameScene.maskLeftEdge) != 0
//            {
//                gameLogic?.onLeftEdge();
//            }
//            else if (bodyB.contactTestBitMask & GameScene.maskRightEdge) != 0
//            {
//                gameLogic?.onRightEdge();
//            }
            if (bodyB.contactTestBitMask & GameScene.maskSpike) != 0
            {
                gameLogic?.onDeath();
            }
            else if (bodyB.contactTestBitMask & GameScene.maskCoin) != 0
            {
                gameLogic?.collectedCoin();
            }
        }
    }
    
    public func setScore(_ newScore : Int)
    {
        scoreLabel?.text = String(newScore);
        //scoreLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        //scoreLabel?.run(SKAction.scale()
        
        let bigger = SKAction.scale(to: 2, duration: 0.1);
        let smaller = SKAction.scale(to: 1.0, duration: 0.2);
        let sequence = SKAction.sequence([bigger, smaller]);
        scoreLabel?.run(sequence);
    }
    
    public func onGameOver(_ bestScore : Int, _ isNewBest : Bool)
    {
        gameOverLabel?.run(SKAction.fadeAlpha(to: 1.0, duration: 0.5))
        if isNewBest
        {
            bestScoreLabel?.text = "NEW HI-SCORE!";
        }
        else
        {
            bestScoreLabel?.text = "BEST: " + String(bestScore);
        }
        
        let delay = SKAction.wait(forDuration: 0.5);
        let show = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        
        bestScoreLabel?.run(SKAction.sequence([delay, show]));
        
        let playAgainLabel = ButtonNode(fontNamed:"Chalkduster")
        playAgainLabel.position.y = -340;
        playAgainLabel.zPosition = 100;
        playAgainLabel.name = "playAgainButton";
        playAgainLabel.text = "AGAIN";
        playAgainLabel.fontSize = 120
        //myLabel.isUserInteractionEnabled = true;
        CTFontManagerCopyAvailablePostScriptNames()
        addChild(playAgainLabel)
        
        let returnLabel = ButtonNode(fontNamed:"Chalkduster")
        returnLabel.position.y = -490
        returnLabel.zPosition = 100;
        returnLabel.name = "returnButton";
        returnLabel.text = "MENU";
        returnLabel.fontSize = 96
        //myLabel.isUserInteractionEnabled = true;
        CTFontManagerCopyAvailablePostScriptNames()
        addChild(returnLabel)
        
    }
}
