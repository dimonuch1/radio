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

//MARK: - Structs screen size

    //изменения для commit number one

    //изменения для commit number two

    //изменения для commit number three
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6_7        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P_7P      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1024.0
        static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1366.0
    }
    
//MARK: - Constraints

    //ha-ha-ha

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
    
//buttons form menu
    
    @IBOutlet var buttonsFormMenu: [UIButton]!
    
//menu constraint
    
    var menuOpen = false
    
    @IBOutlet weak var leadingMenu: NSLayoutConstraint!
    
    @IBOutlet weak var menuView: UIView!
    
    
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
        //main view
//        let swipeRightMainView = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGestureForMainView))
//        let swipeLeftMainView = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGestureForMainView))
//        swipeRightMainView.direction = UISwipeGestureRecognizerDirection.right
//        swipeLeftMainView.direction = UISwipeGestureRecognizerDirection.left
//        self.view.addGestureRecognizer(swipeRightMainView)
//        self.view.addGestureRecognizer(swipeLeftMainView)
        //let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        //tap.delegate = self.view as! UIGestureRecognizerDelegate?
        //self.view.addGestureRecognizer(tap)
        
        //other
        heightHeart.constant    = self.view.bounds.height * 0.1
        heightNameSong.constant = self.view.bounds.height * 0.05
        play = false
        buttonPlay.backgroundColor = UIColor.clear
        
        heightSoundImage.constant      = self.view.bounds.height * 0.05
    
        soundLeftConstraint.constant   = self.view.bounds.width * 0.1
        slider.widthAnchor.constraint(equalToConstant: soundLeftConstraint.constant + heightSoundImage.constant + sliderToSound.constant)
        
        //menu
        self.menuView.layer.cornerRadius = 4
        leadingMenu.constant = -self.view.bounds.width
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGestureForMenuView))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.menuView.addGestureRecognizer(swipeLeft)
        self.menuView.layer.shadowColor = UIColor.white.cgColor
        self.menuView.layer.shadowRadius = 20
        self.menuView.layer.shadowOpacity = 0.5
        
        view.layoutIfNeeded()
        view.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()

        //view did laod

        //abrakadabra

        identifySizeScreen()
        
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.barTintColor = UIColor.black
        self.view.backgroundColor = UIColor.black
        
        let url = "http://pl.radiosolyanka.in.ua:8000/play"
        
        let playerItem = AVPlayerItem(url: NSURL(string:url) as! URL)
        player = AVPlayer(playerItem: playerItem)
        player.volume = 0.8
        player.pause()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        sound.isUserInteractionEnabled = true
        sound.addGestureRecognizer(tapGestureRecognizer)
        
        if (player.rate != 0 && player.error == nil) {
            print("playing")
        } else {
            print("error",player.error ?? "")
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
        UIView.animate(withDuration: 1) {
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

    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        self.soundOff = !self.soundOff
        if !soundOff {
            self.sound.image = UIImage(named: "nosound")
            slider.value = 0
            player.volume = 0
        } else {
            self.sound.image = UIImage(named: "sound")
            slider.value = 0.8
            player.volume = 0.8
        }
    }
    
    @IBAction func OpenMenu(_ sender: UIBarButtonItem) {
        if self.menuOpen {
            closeMenu()
        } else {
            openMenu()
        }
    }
    
    func openMenu() {
        self.leadingMenu.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.menuOpen = !self.menuOpen
        })
    }
    
    func closeMenu() {
        self.leadingMenu.constant = -self.menuView.frame.width
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
            self.menuOpen = !self.menuOpen
        })
    }
    
    func respondToSwipeGestureForMenuView(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right: break
            case UISwipeGestureRecognizerDirection.down:  break
            case UISwipeGestureRecognizerDirection.left:  closeMenu()
            case UISwipeGestureRecognizerDirection.up:    break
            default: break
            }
        }
    }
    
    
    func respondToSwipeGestureForMainView(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right: break//openMenu()
            case UISwipeGestureRecognizerDirection.down:  break
            case UISwipeGestureRecognizerDirection.left:  break//closeMenu()
            case UISwipeGestureRecognizerDirection.up:    break
            default: break
            }
        }
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        if menuOpen {
            closeMenu()
        }
    }

    
//MARK: - Buttons font size
    
    func identifySizeScreen() {
        
        if DeviceType.IS_IPHONE_4_OR_LESS {
            setButtonsFontSize(14.0)
        } else if DeviceType.IS_IPHONE_5 {
            setButtonsFontSize(16.0)
        } else if DeviceType.IS_IPHONE_6_7 {
            setButtonsFontSize(18.0)
        } else if DeviceType.IS_IPHONE_6P_7P {
            setButtonsFontSize(20.0)
        } else {
            setButtonsFontSize(22.0)
        }
    }
    
    func setButtonsFontSize(_ font:CGFloat) {
        for button in buttonsFormMenu {
            button.titleLabel?.font = UIFont(name: (button.titleLabel?.font.fontName)!, size: font)
        }
    }
    
}
