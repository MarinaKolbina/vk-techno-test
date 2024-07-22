//
//  SunScene.swift
//  vk-techno-test
//
//  Created by Marina Kolbina on 22/07/2024.
//

import SpriteKit

class SunScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.cyan
        
        let sun = SKShapeNode(circleOfRadius: 50)
        sun.fillColor = SKColor.yellow
        sun.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(sun)
        
        let rotateAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 10)
        let repeatAction = SKAction.repeatForever(rotateAction)
        sun.run(repeatAction)
        
        for i in 0..<8 {
            let ray = SKShapeNode(rectOf: CGSize(width: 10, height: 250))
            ray.fillColor = SKColor.yellow
            ray.position = CGPoint(x: sun.position.x, y: sun.position.y)
            ray.zRotation = CGFloat.pi / 4 * CGFloat(i)
            ray.run(repeatAction)
            addChild(ray)
        }
        
        if let sunnyEmitter = SKEmitterNode(fileNamed: "SunParticle.sks") {
            sunnyEmitter.position = CGPoint(x: size.width / 2, y: size.height / 2)
            addChild(sunnyEmitter)
        }
    }
}
