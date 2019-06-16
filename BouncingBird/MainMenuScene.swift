//
//  MainMenuScene.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 12/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    private var bestScoreLabel : SKLabelNode?
    
    override func sceneDidLoad()
    {
        let startGameLabel = ButtonNode(fontNamed:"Chalkduster")
        startGameLabel.name = "startGameButton";
        startGameLabel.text = "PLAY";
        startGameLabel.fontSize = 144
        //myLabel.isUserInteractionEnabled = true;
        CTFontManagerCopyAvailablePostScriptNames()
        addChild(startGameLabel)
        
        self.bestScoreLabel = self.childNode(withName: "//bestScoreLabel") as? SKLabelNode
        bestScoreLabel?.text = "Best: " + String(GameLogic.loadBestScore());
        
//        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
//        var temp = SKSpriteNode(imageNamed: "Player.png");
//        temp.physicsBody?.affectedByGravity = true;
//        temp.physicsBody?.isDynamic = true;
//        addChild(temp);
    }
    
    override func didMove(to view: SKView) {
        
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//        
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//        
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//            
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print("touched");
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
//        let gameSceneTemp = GameScene(fileNamed: "GameScene");
//        self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fade(withDuration: 1.0));
        
        for touch in touches
        {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "startGameButton"
            {
                let gameSceneTemp = GameScene(fileNamed: "GameScene");
                //let gameSceneTemp = MainMenuScene(fileNamed: "MainMenuScene");
                //gameSceneTemp?.setScale(1)
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
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
