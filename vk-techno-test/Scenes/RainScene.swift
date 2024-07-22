//
//  RainScene.swift
//  vk-techno-test
//
//  Created by Marina Kolbina on 22/07/2024.
//

import SpriteKit

class RainScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        if let rainEmitter = SKEmitterNode(fileNamed: "RainParticle.sks") {
            rainEmitter.position = CGPoint(x: size.width / 2, y: size.height - 50)
            rainEmitter.particlePositionRange = CGVector(dx: size.width, dy: 0)
            addChild(rainEmitter)
        }
    }
}
