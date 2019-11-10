//-----------------------------------------------------------------
//  File: TiltScoreViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Hamlet Jiang Su
//
//  Description: View controller that displays once TILT has reached a count of 0. Shows the score and options to
//                  quit or replay.
//
//  Changes:
//      - Added comments to clarify code
//      - Added scene to main storyboard
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import UIKit
import AVFoundation

class TiltScoreViewController: UIViewController {
    
    var fScore: Int = 0
    @IBOutlet weak var finalScore: UILabel!
    
    /**
     Function runs when this current view has been loaded. Updates the score based on the score of the previous game.
     
     - Returns: None.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finalScore.text = String(fScore)
    }
    
}
