//
//  MainMenuScene.swift
//  BouncingBird
//
//  Created by Robert Dudziński on 12/06/2019.
//  Copyright © 2019 Robert. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainMenuScene: SKScene
{
    private var bestScoreLabel : SKLabelNode?
    
    override func sceneDidLoad()
    {
        let startGameLabel = ButtonNode(fontNamed:"Chalkduster")
        startGameLabel.name = "startGameButton";
        startGameLabel.text = "PLAY";
        startGameLabel.fontSize = 144
        CTFontManagerCopyAvailablePostScriptNames()
        addChild(startGameLabel)
        
        self.bestScoreLabel = self.childNode(withName: "//bestScoreLabel") as? SKLabelNode
        bestScoreLabel?.text = "Best: " + String(GameLogic.loadBestScore());
    }
    
    override func didMove(to view: SKView)
    {
        
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
        for touch in touches
        {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "startGameButton"
            {
                let gameSceneTemp = GameScene(fileNamed: "GameScene");
                gameSceneTemp!.scaleMode = .aspectFill
                self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fade(withDuration: 1.0));
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval)
    {

    }
}
