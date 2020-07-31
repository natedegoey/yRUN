//
//  ViewController.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-26.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
   override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            setUpElements()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            // set up video in the background
            setUpVideo()
        }

        func setUpElements() {
            
            Utilities.styleFilledButton(signUpButton)
            Utilities.styleHollowButton(loginButton)
            
        }
        
        func setUpVideo() {
            
            // Generate a random video and assign it to a variable
            let randNum = Int.random(in: 1...6)
            let vidName = "video\(randNum)"
            // Get the path to the resource in the bundle
            let bundlePath = Bundle.main.path(forResource: vidName, ofType: "mp4")
            //let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
            //let bundlePath = Bundle.main.path(forResource: "10Z_IMG_1721", ofType: "mp4")
            
            guard bundlePath != nil else {
                return
            }
            
            // Create a URL from it
            let url = URL(fileURLWithPath: bundlePath!)
            
            // Create the video player item
            let item = AVPlayerItem(url: url)
            
            // Create the player
            videoPlayer = AVPlayer(playerItem: item)
            
            // Create the layer
            videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
            
            // Adjust the size and frame
            videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
            // videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
            view.layer.insertSublayer(videoPlayerLayer!, at: 0)
            
            // Add it to the view and play it
            if randNum > 3 {
                videoPlayer?.playImmediately(atRate: 1.0)
            } else {
                videoPlayer?.playImmediately(atRate: 0.3)
            }
        }

    }
