//
//  GameViewController.swift
//  Tetrios
//
//  Created by Alexander Pan on 7/16/17.
//  Copyright (c) 2017 Alex Pan. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene: GameScene!
    var tetrios:Tetrios!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick
        
        tetrios = Tetrios()
        tetrios.beginGame()

        // Present the scene.
        skView.presentScene(scene)
        
        scene.addPreviewShapeToScene(tetrios.nextShape!) {
            self.tetrios.nextShape?.moveTo(StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(self.tetrios.nextShape!) {
                let nextShapes = self.tetrios.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(nextShapes.nextShape!) {}
            }
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func didTick() {
        tetrios.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(tetrios.fallingShape!, completion: {})
    }
    
}
