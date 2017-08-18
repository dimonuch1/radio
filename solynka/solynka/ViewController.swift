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
import WCLShineButton



class ViewController: UIViewController {

    @IBOutlet weak var heightHeart: NSLayoutConstraint!
    
    @IBOutlet weak var heightNameSong: NSLayoutConstraint!
    
    @IBOutlet weak var heightSoundImage: NSLayoutConstraint!
    
    @IBOutlet weak var viewForHeart: UIView!
    
    //var moviePlayer:MPMoviePlayerController!
    var player = AVPlayer()
    
    
    func setConstraints() {
        heightHeart.constant = self.view.bounds.height * 0.1
        heightNameSong.constant = self.view.bounds.height * 0.05
        view.layoutIfNeeded()
        view.setNeedsLayout()
        print(viewForHeart.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        UIApplication.shared.statusBarStyle = .lightContent
       // UINavigationBar.appearance().backgroundColor =  UIColor.red
        navigationController?.navigationBar.barTintColor = UIColor.black
        self.view.backgroundColor = UIColor.black
        
        var url = "http://pl.radiosolyanka.in.ua:8000/play"
        
        
       
        let playerItem = AVPlayerItem(url: NSURL(string:url) as! URL)
        player = AVPlayer(playerItem: playerItem)
        //player.rate = 1.0
        
        
        var param1 = WCLShineParams()
        
        //param1.bigShineColor = UIColor(rgb: (153,152,38))
        param1.bigShineColor = UIColor.red
        //param1.smallShineColor = UIColor(rgb: (102,102,102))
        param1.smallShineColor = UIColor.orange
        
        
        
        let bt1 = WCLShineButton(frame: .init(x: viewForHeart.bounds.minX, y: viewForHeart.bounds.minY, width:viewForHeart.bounds.maxX , height: viewForHeart.bounds.maxY), params: param1)
        
        //bt1.fillColor = UIColor(rgb: (153,152,38))
        bt1.fillColor = UIColor.red
        //bt1.color = UIColor(rgb: (170,170,170))
        bt1.color = UIColor.gray
        bt1.addTarget(self, action: #selector(action), for: .touchUpInside )
        self.viewForHeart.addSubview(bt1)
        //view.addSubview(bt1)
        //bt1.translatesAutoresizingMaskIntoConstraints = false
        //bt1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant:-50).isActive = true
        //bt1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        print(view.bounds)
        print(view.bounds.height*0.1)
        print(viewForHeart.bounds)
    }

    func action() {
        print("action")
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

