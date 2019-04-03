//
//  ViewController.swift
//  MorseCodeLight
//
//  Created by Nikita Traydakalo on 3/28/19.
//  Copyright © 2019 Nikita Traydakalo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var morse = [String:String]()
    
    @IBOutlet weak var textCode: UITextView!
    @IBOutlet weak var morseCode: UITextView!
    var timer: Timer?
    var count = 0
    var text = String()
    var url = URL(fileURLWithPath: "")
    var player: AVAudioPlayer?
    var isPlay = false
    
    
    @IBAction func okButtonPush(_ sender: UIButton) {
        
        text = ""
        count = 0
        textCode.text.forEach {
            if let appendedString = morse[String($0).lowercased()] {
                text.append(appendedString)
                if $0 != " " {
                    text.append("___")
                }
            }
        }
        morseCode.text = text

        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func timerTick() {
        if count < text.count {
            guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
            guard device.hasTorch else { return }
            
            do {
                try device.lockForConfiguration()
                if String(text[text.index(text.startIndex, offsetBy: count)]) == "_" {
                    player?.stop()
                    isPlay = false
                    device.torchMode = AVCaptureDevice.TorchMode.off
                } else {
                    if !isPlay {
                        playSound()
                    }
                    
                    
                    isPlay = true
                    try device.setTorchModeOn(level: 1.0)
                }
                device.unlockForConfiguration()
                count += 1
            } catch {
                print(error)
            }
        } else {
            timer?.invalidate()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   
    
    func playSound() {
        
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.currentTime = 1.0
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }


    override func viewDidLoad() {
        //super.viewDidLoad()
        
        morse["a"] = "*_***" //".-"
        morse["b"] = "***_*_*_*"//"-..."
        morse["c"] = "***_*_***_*"//"-.-."
        morse["d"] = "***_*_*"//"-.."
        morse["e"] = "*"//"."
        morse["f"] = "*_*_***_*"//"..-."
        morse["g"] = "***_***_*"//"--."
        morse["h"] = "*_*_*_*"//"...."
        morse["i"] = "*_*"//".."
        morse["j"] = "*_***_***_***"//".---"
        morse["k"] = "***_*_***"//"-.-"
        morse["l"] = "*_***_*_*"//".-.."
        
        morse["m"] = "***_***"//"--"
        morse["n"] = "***_*"//"-."
        morse["o"] = "***_***_***"//"---"
        morse["p"] = "*_***_***_*"//".--."
        morse["q"] = "***_***_*_***"//"--.-"
        morse["r"] = "*_***_*"//".-."
        morse["s"] = "*_*_*"//"..."
        morse["t"] = "***"//"-"
        morse["u"] = "*_*_***"//"..-"
        morse["v"] = "*_*_*_***"//"...-"
        morse["w"] = "*_***_***"//".--"
        morse["x"] = "***_*_*_***"//"-..-"
        morse["y"] = "***_*_***_***"//"-.--"
        morse["z"] = "***_***_*_*"//"--.."
        
        morse["1"] = "*_***_***_***_***"//".----"
        morse["2"] = "*_*_***_***_***"//"..---"
        morse["3"] = "*_*_*_***_***"//"...--"
        morse["4"] = "*_*_*_*_***"//"....-"
        morse["5"] = "*_*_*_*_*"//"....."
        morse["6"] = "***_*_*_*_*"//"-...."
        morse["7"] = "***_***_*_*_*"//"--..."
        morse["8"] = "***_***_***_*_*"//"---.."
        morse["9"] = "***_***_***_***_*"//"----."
        morse["0"] = "***_***_***_***_***"//"-----"
        morse[" "] = "____"
        
        
        self.textCode.delegate = self as? UITextViewDelegate
        
        
        guard let url = Bundle.main.url(forResource: "c6", withExtension: "mp3") else { return }
        self.url = url
    }


}


extension ViewController: UITextFieldDelegate {
     public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        return true
    }
}




//class ViewController: UIViewController {
//    var audioPlayer: AVAudioPlayer?
//    var urls = [URL]()
//
//    @IBOutlet var noteBtn: [UIButton]!
//    @IBAction func PushBtn(_ sender: UIButton) {
//        let id = Int(noteBtn.index(of: sender) ?? -1)
//        if id >= 0 && id < noteBtn.count {
//            audioPlayer = try? AVAudioPlayer(contentsOf: urls[id], fileTypeHint: nil)
//            audioPlayer?.setVolume(0.5, fadeDuration: 0.1)
//            audioPlayer?.play()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//        let pathes = ["c1", "c1s", "d1", "d1s", "e1", "f1", "f1s", "g1", "g1s", "a1", "a1s", "b1"]
//
//        for path in pathes {
//            guard let tmpPath = Bundle.main.path(forResource: path, ofType: "wav")
//                else {continue }
//            let url = URL(fileURLWithPath: tmpPath)
//            urls.append(url)
//        }
//    }
//
//
//}
//
