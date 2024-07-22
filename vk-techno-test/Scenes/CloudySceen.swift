//
//  CloudySceen.swift
//  vk-techno-test
//
//  Created by Marina Kolbina on 22/07/2024.
//

import SpriteKit
import GameplayKit

class CloudyScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.gray
        
        // Add clouds
        for _ in 0..<5 {
            let cloud = createCloud()
            cloud.position = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
            addChild(cloud)
        }
    }
    
    func createCloud() -> SKSpriteNode {
        let cloudTexture = SKTexture(imageNamed: "cloudImage")
        let cloud = SKSpriteNode(texture: cloudTexture)
        cloud.setScale(CGFloat.random(in: 0.1...0.6))
        
        let moveLeft = SKAction.moveBy(x: -size.width, y: 0, duration: TimeInterval(CGFloat.random(in: 10.0...20.0)))
        let moveReset = SKAction.moveBy(x: size.width, y: 0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft, moveReset])
        let moveForever = SKAction.repeatForever(moveSequence)
        
        cloud.run(moveForever)
        
        return cloud
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Handle any updates
    }
}

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = CloudyScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

