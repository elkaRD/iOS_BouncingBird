//
//  GameScene.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 12/06/2019.
//  Copyright © 2019 Robert Dudzinski. All rights reserved.
//
//  EN: Project for 'Programming for Mobile Apple iOS and MacOS X' course
//      Warsaw University of Technology
//
//  PL: Projekt APIOS (Programowanie dla systemów: mobilnego iOS oraz MacOS X)
//      PW WEiTI 19L
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    private var scoreLabel : SKLabelNode?
    private var gameOverLabel : SKLabelNode?
    private var bestScoreLabel : SKLabelNode?
    
    private var gameLogic : GameLogic?
    
    private var lastUpdateTimeInterval: CFTimeInterval?
    private var minTimeInterval: CFTimeInterval = 0;
    
    public static let maskPlayer : UInt32 = 2;
    public static let maskRightEdge : UInt32 = 4;
    public static let maskLeftEdge : UInt32 = 8;
    public static let maskSpike : UInt32 = 16;
    public static let maskCoin : UInt32 = 32;
    public static let maskTopBottomEdge : UInt32 = 64;
    public static let maskEverything : UInt32 = 4294967295;
    
    override func sceneDidLoad()
    {
        physicsWorld.gravity = CGVector(dx: 0, dy: -9)
        gameLogic = GameLogic(self);
        
        let physicsBody = SKPhysicsBody (edgeLoopFrom: self.frame)
        self.physicsBody = physicsBody
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        self.scoreLabel = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.scoreLabel {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.gameOverLabel = self.childNode(withName: "//gameOverLabel") as? SKLabelNode
        self.bestScoreLabel = self.childNode(withName: "//bestScoreLabel") as? SKLabelNode
    }
    
    
    func touchDown(atPoint pos : CGPoint)
    {

    }
    
    func touchMoved(toPoint pos : CGPoint)
    {

    }
    
    func touchUp(atPoint pos : CGPoint)
    {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        gameLogic!.jump();
        
        for touch in touches
        {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "playAgainButton"
            {
                launchGame();
                SoundManager.playSound(self, SoundManager.SoundType.Click);
            }
            else if touchedNode.name == "returnButton"
            {
                launchMainMenu();
                SoundManager.playSound(self, SoundManager.SoundType.Click);
            }
        }
    }
    
    private func launchGame()
    {
        let gameSceneTemp = GameScene(fileNamed: "GameScene");
        gameSceneTemp!.scaleMode = .aspectFill
        self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fade(withDuration: 1.0));
    }
    
    private func launchMainMenu()
    {
        let gameSceneTemp = MainMenuScene(fileNamed: "MainMenuScene");
        gameSceneTemp!.scaleMode = .aspectFill
        self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fade(withDuration: 1.0));
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
        
        var delta: CFTimeInterval = currentTime
        if let luti = lastUpdateTimeInterval {
            delta = currentTime - luti
        }
        
        lastUpdateTimeInterval = currentTime
        
        if delta > 1.0
        {
            delta = minTimeInterval
        }
        
        gameLogic!.update(CGFloat(delta));
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        let bodyA = contact.bodyA;
        let bodyB = contact.bodyB;
        
        if (bodyA.contactTestBitMask & GameScene.maskPlayer) != 0
        {
            if (bodyB.categoryBitMask & GameScene.maskLeftEdge) != 0
            {
                gameLogic?.onCollisionLeft();
            }
            else if (bodyB.categoryBitMask & GameScene.maskRightEdge) != 0
            {
                gameLogic?.onCollisionRight()
            }
            else if (bodyB.categoryBitMask & GameScene.maskSpike) != 0
            {
                gameLogic?.onDeath();
            }
            else if (bodyB.categoryBitMask & GameScene.maskCoin) != 0
            {
                gameLogic?.collectedCoin();
            }
        }
    }
    
    public func setScore(_ newScore : Int)
    {
        scoreLabel?.text = String(newScore);
        
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
            let particles = SKEmitterNode(fileNamed: "ParticlesHighScore.sks");
            particles?.position.x = 20;
            particles?.position.y = -123;
            addChild(particles!);
        }
        else
        {
            bestScoreLabel?.text = "BEST: " + String(bestScore);
        }
        
        let delay = SKAction.wait(forDuration: 0.5);
        let show = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        
        bestScoreLabel?.run(SKAction.sequence([delay, show]));
        
        drawRestartButton();
        drawReturnButton();
    }
    
    private func drawRestartButton()
    {
        let playAgainLabel = SKLabelNode(fontNamed:"Chalkduster")
        playAgainLabel.position.y = -340;
        playAgainLabel.zPosition = 100;
        playAgainLabel.name = "playAgainButton";
        playAgainLabel.text = "AGAIN";
        playAgainLabel.fontSize = 120
        CTFontManagerCopyAvailablePostScriptNames()
        addChild(playAgainLabel)
    }
    
    private func drawReturnButton()
    {
        let returnLabel = SKLabelNode(fontNamed:"Chalkduster")
        returnLabel.position.y = -490
        returnLabel.zPosition = 100;
        returnLabel.name = "returnButton";
        returnLabel.text = "MENU";
        returnLabel.fontSize = 96
        CTFontManagerCopyAvailablePostScriptNames()
        addChild(returnLabel)
    }
}
