//
//  ViewController.swift
//  solynka
//
//  Created by Сергей Ганжа on 26.04.17.
//  Copyright © 2017 Сергей Ганжа. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

   var moviePlayer:MPMoviePlayerController!
    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        var url:NSURL = NSURL(string: "http://pl.radiosolyanka.in.ua:8000/play")!
        
        moviePlayer = MPMoviePlayerController(contentURL: url as URL!)
        
        moviePlayer.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        moviePlayer.view.sizeToFit()
        
        moviePlayer.movieSourceType = MPMovieSourceType.streaming
        
        self.view.addSubview(moviePlayer.view)
        
        moviePlayer.isFullscreen = true
        moviePlayer.prepareToPlay()
        moviePlayer.play()
        
        moviePlayer.controlStyle = MPMovieControlStyle.embedded
*/
        
        
        var url = "http://pl.radiosolyanka.in.ua:8000/play"
        
        
       
        let playerItem = AVPlayerItem(url: NSURL(string:url) as! URL)
        player = AVPlayer(playerItem: playerItem)
        //player.rate = 1.0
               
    }

    
    
    @IBAction func play(_ sender: UIButton) {
        player.play()

    }
    
    
    @IBAction func stop(_ sender: UIButton) {
        player.pause()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

