//
//  GameViewController.swift
//  Tetrios
//
//  Created by Alexander Pan on 7/16/17.
//  Copyright (c) 2017 Alex Pan. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, TetriosDelegate {
    
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
        tetrios.delegate = self
        tetrios.beginGame()

        // Present the scene.
        skView.presentScene(scene)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func didTick() {
        tetrios.letShapeFall()
    }
    
    func nextShape() {
        let newShapes = tetrios.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
        self.scene.movePreviewShape(fallingShape) {
            // #16
            self.view.userInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(tetrios: Tetrios) {
        // The following is false when restarting a new game
        if tetrios.nextShape != nil && tetrios.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(tetrios.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(tetrios: Tetrios) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(tetrios: Tetrios) {
        
    }
    
    func gameShapeDidDrop(tetrios: Tetrios) {
        
    }
    
    func gameShapeDidLand(tetrios: Tetrios) {
        scene.stopTicking()
        nextShape()
    }
    
    func gameShapeDidMove(tetrios: Tetrios) {
        scene.redrawShape(tetrios.fallingShape!) {}
    }
    
}
