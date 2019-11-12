//
//  BubbleScoreViewController.swift
//  ParkinSense
//
//  Created by 包立诚 on 2019/11/11.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import UIKit
import AVFoundation

class BubbleScoreViewController: UIViewController {

    var fScore: Int = 0
    @IBOutlet weak var BubbleFinalScore: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BubbleFinalScore.text = String(fScore)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
