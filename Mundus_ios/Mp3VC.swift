//
//  Mp3VC.swift
//  Mundus_ios
//
//  Created by Stephan on 11/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class Mp3VC: UIViewController {
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()

        // Do any additional setup after loading the view.
    }

    func playSound() {
        let url = Bundle.main.url(forResource: "Mundus_introduction", withExtension: "mp3")!

        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
