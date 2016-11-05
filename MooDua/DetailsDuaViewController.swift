//
//  DetailsDuaViewController.swift
//  MooDua
//
//  Created by Rachid on 24/10/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import UIKit
import AVFoundation

class DetailsDuaViewController: UIViewController {

    var duaInfo : (String?,String?,String?,String?)?
    
    private var player : AVPlayer?
    private var isPlaying = false
    private var playerItem : AVPlayerItem?

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var sliderAudio: UISlider!
    @IBOutlet weak var backgroundImageDuaView: UIImageView!
    @IBOutlet weak var duaTextView: UITextView!{
        didSet{
            addTextToView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareFront()
        prepareAudio()
        
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(DetailsDuaViewController.updateAudioSlider), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        isPlaying = false
        player = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
   private func addTextToView() {
        duaTextView.text.append((duaInfo?.0)!)
        duaTextView.text.append("\r\n\n\n")
        
        duaTextView.text.append((duaInfo?.1)!)
        duaTextView.text.append("\r\n\n\n")
        
        duaTextView.text.append((duaInfo?.2)!)
        duaTextView.text.append("\r\n\n\n")
    }

    
    // MARK : PREPARATION FROND & AUDIO
    
    private func prepareFront() {
        let lightBlur = UIBlurEffect(style: UIBlurEffectStyle.light )
        let blurView = UIVisualEffectView(effect: lightBlur)
        
        blurView.alpha = 0.8
        blurView.frame = backgroundImageDuaView.bounds
        backgroundImageDuaView.addSubview(blurView)
    }
    
    private func prepareAudio() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(DetailsDuaViewController.updateAudioSetting), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        let url = URL(string: (duaInfo?.3)!)
        
        playerItem = AVPlayerItem( url: url! )
        player = AVPlayer(playerItem:playerItem)
        player?.volume = 2.0
        
        let duration = CMTimeGetSeconds((player?.currentItem?.asset.duration)!)
        
        sliderAudio.maximumValue = Float(duration)
        sliderAudio.minimumValue = 0.0
        sliderAudio.value = 0.0
    }
   
    
    
    func playbackSliderValueChanged()
    {
        
        let seconds : Int64 = Int64(sliderAudio.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        player?.seek(to: targetTime)
        
        if player?.rate == 0
        {
            player?.play()
        }
    }
    
    // MARK : AUDIO CONTROLLER
    
    @IBAction func playDua(_ sender: UIButton) {
        if !isPlaying {
            player?.play()
            sender.setImage(UIImage(named: "pause"), for: UIControlState.normal)
            isPlaying = true
        }
        else{
            player?.pause()
            sender.setImage(UIImage(named: "play"), for: UIControlState.normal)
            isPlaying = false
        }

    }
    
    @IBAction func changeAudioTime(_ sender: UISlider) {
        if isPlaying{
            let seconde = TimeInterval(sender.value)
            let time = CMTimeMake(Int64(seconde), 1)
        
            player?.pause()
            player?.seek(to: time)
            player?.play()
        }
    }
    
    func updateAudioSlider() {
        if isPlaying {
            sliderAudio.value = Float(CMTimeGetSeconds((player?.currentTime())!))
        }
    }
    
    func updateAudioSetting() {
        print("FUCK")
        playButton.setImage(UIImage(named: "play"), for: UIControlState.normal)
        isPlaying = false
        prepareAudio()
    }
    
    
    
    
    
    
    
   
}
