//
//  LightningScene.swift
//  vk-techno-test
//
//  Created by Marina Kolbina on 22/07/2024.
//

import SpriteKit

class LightningScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        startLightning()
    }
    
    func startLightning() {
        let lightning = SKShapeNode()
        addChild(lightning)
        
        let createLightning = SKAction.run { [weak self] in
            guard let self = self else { return }
            lightning.removeAllChildren()
            self.drawLightning(on: lightning)
        }
        
        let wait = SKAction.wait(forDuration: 1.0, withRange: 0.5)
        let sequence = SKAction.sequence([createLightning, wait])
        let repeatAction = SKAction.repeatForever(sequence)
        
        run(repeatAction)
    }
    
    func drawLightning(on node: SKNode) {
        let path = UIBezierPath()
        let startX = CGFloat.random(in: 0...size.width)
        let startY = size.height
        path.move(to: CGPoint(x: startX, y: startY))
        
        var currentPoint = CGPoint(x: startX, y: startY)
        
        while currentPoint.y > 0 {
            let nextX = currentPoint.x + CGFloat.random(in: -10...10)
            let nextY = currentPoint.y - CGFloat.random(in: 10...20)
            let nextPoint = CGPoint(x: nextX, y: nextY)
            path.addLine(to: nextPoint)
            currentPoint = nextPoint
        }
        
        let shapeNode = SKShapeNode(path: path.cgPath)
        shapeNode.strokeColor = .white
        shapeNode.lineWidth = 2.0
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.2)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([fadeOut, remove])
        shapeNode.run(sequence)
        
        node.addChild(shapeNode)
    }
}
