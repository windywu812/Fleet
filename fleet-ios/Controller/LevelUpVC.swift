//
//  LevelUpVC.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 01/06/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import AVFoundation

class LevelUpVC: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    
    var nextLevel: Int!
    var player: AVPlayer!
    var fleetVC: FleetController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = Bundle.main.path(forResource: "toLevel\(nextLevel!)", ofType:"mp4") else {
            debugPrint("toLevel\(nextLevel!).mp4 not found")
            return
        }
        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = CGRect(x: 0, y: 0, width: videoView.frame.width, height: videoView.frame.height)
        playerLayer.cornerRadius = 5
        playerLayer.masksToBounds = true
        videoView.layer.addSublayer(playerLayer)
        videoView.layer.cornerRadius = 5
        videoView.clipsToBounds = true
        
        player.play()
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        fleetVC?.setupMascot()
        fleetVC?.checkProgress()
        dismiss(animated: true, completion: nil)
    }
}
