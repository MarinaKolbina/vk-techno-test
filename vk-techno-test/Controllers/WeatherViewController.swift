//
//  WeatherViewController.swift
//  vk-techno-test
//
//  Created by Marina Kolbina on 22/07/2024.
//

import UIKit
import SpriteKit

enum WeatherCondition: CaseIterable {
    case rain, snow, sun, cloudy, lightning
}

class WeatherViewController: UIViewController {
    var weatherCondition: WeatherCondition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupScene()
    }
    
    private func setupScene() {
        let skView = SKView(frame: self.view.bounds)
        self.view.addSubview(skView)
        
        guard let weatherCondition = weatherCondition else { return }
        
        let scene: SKScene
        switch weatherCondition {
        case .rain:
            scene = RainScene(size: skView.bounds.size)
        case .snow:
            scene = SnowScene(size: skView.bounds.size)
        case .sun:
            scene = SunScene(size: skView.bounds.size)
//            case .cloudy:
//                scene = CloudyScene(size: skView.bounds.size)
        case .lightning:
            scene = LightningScene(size: skView.bounds.size)
        default:
            scene = RainScene(size: skView.bounds.size)
        }
        
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
}

