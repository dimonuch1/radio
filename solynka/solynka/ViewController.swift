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

    
//MARK: - Constraints
    
//heart
    @IBOutlet weak var heightHeart: NSLayoutConstraint!
    
    @IBOutlet weak var viewForHeart: UIView!
    
//nameSound
    @IBOutlet weak var heightNameSong: NSLayoutConstraint!
    
//volume and slider
    @IBOutlet weak var sound: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var heightSoundImage: NSLayoutConstraint!
    
    @IBOutlet weak var soundLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sliderToSound: NSLayoutConstraint!
    
    @IBOutlet weak var sliderRightConstraint: NSLayoutConstraint!
    
    var soundOff:Bool = true {
        didSet {
            
        }
    }
//button play
    @IBOutlet weak var buttonPlay: UIButton!
    
//other
    
    var play:Bool = false {
        didSet {
            self.changeImageButtonPlay(play)
        }
    }
    
    //var moviePlayer:MPMoviePlayerController!
    var player = AVPlayer()
    
    
    func setConstraints() {
        heightHeart.constant    = self.view.bounds.height * 0.1
        heightNameSong.constant = self.view.bounds.height * 0.05
        //buttonPlay.setBackgroundImage(UIImage(named:"play"), for: .normal)
        play = false
        buttonPlay.backgroundColor = UIColor.clear
        
        heightSoundImage.constant      = self.view.bounds.height * 0.05
    
        soundLeftConstraint.constant   = self.view.bounds.width * 0.1
        slider.widthAnchor.constraint(equalToConstant: soundLeftConstraint.constant + heightSoundImage.constant + sliderToSound.constant)
        view.layoutIfNeeded()
        view.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.barTintColor = UIColor.black
        self.view.backgroundColor = UIColor.black
        
        var url = "http://pl.radiosolyanka.in.ua:8000/play"
        
        let playerItem = AVPlayerItem(url: NSURL(string:url) as! URL)
        player = AVPlayer(playerItem: playerItem)
        player.volume = 0.8
        player.pause()
        
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        sound.isUserInteractionEnabled = true
        sound.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        if (player.rate != 0 && player.error == nil) {
            print("playing")
        }
        else
        {
            print("error",player.error)
        }
        
        var param1 = WCLShineParams()
        
        param1.bigShineColor = UIColor.red
        param1.smallShineColor = UIColor.orange
        
        let bt1 = WCLShineButton(frame: .init(x: viewForHeart.bounds.minX, y: viewForHeart.bounds.minY, width:viewForHeart.bounds.maxX , height: viewForHeart.bounds.maxY), params: param1)
        
        bt1.fillColor = UIColor.red
        bt1.color = UIColor.gray
        bt1.addTarget(self, action: #selector(action), for: .touchUpInside )
        self.viewForHeart.addSubview(bt1)
    }

    func action() {
        print("action")
    }
    
    func changeImageButtonPlay(_ play:Bool) {
        UIView.animate(withDuration: 2) {
            self.buttonPlay.alpha = 0
            if !play {
                self.buttonPlay.setBackgroundImage(UIImage(named:"play"), for: .normal)
            } else {
                self.buttonPlay.setBackgroundImage(UIImage(named:"paus"), for: .normal)
            }
            self.buttonPlay.alpha = 1
        }
    }
//MARK: - Actions
    
    @IBAction func changeVolume(_ sender: UISlider) {
        
        player.volume = sender.value
        
        if player.volume == 0 {
            sound.image = UIImage(named:"nosound")
        } else {
            sound.image = UIImage(named:"sound")
        }
    }
    
    @IBAction func play(_ sender: UIButton) {
        play == true ? player.pause() : player.play()
        play = !play
    }

    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        self.soundOff = !self.soundOff
        if !soundOff {
            self.sound.image = UIImage(named: "nosound")
            slider.value = 0
        } else {
            self.sound.image = UIImage(named: "sound")
            slider.value = 0.8
        }
        
    }
    
    
}
