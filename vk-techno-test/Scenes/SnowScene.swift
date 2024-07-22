//
//  SnowScene.swift
//  vk-techno-test
//
//  Created by Marina Kolbina on 22/07/2024.
//

import SpriteKit

class SnowScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        if let snowEmitter = SKEmitterNode(fileNamed: "SnowParticle.sks") {
            snowEmitter.position = CGPoint(x: size.width / 2, y: size.height - 50)
            snowEmitter.particlePositionRange = CGVector(dx: size.width, dy: 0)
            addChild(snowEmitter)
        }
    }
}

