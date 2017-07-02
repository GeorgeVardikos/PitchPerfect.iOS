//
//  RecordSoundsVC.swift
//  PitchPerfect
//
//  Created by George Vardikos on 7/3/17.
//  Copyright © 2017 George Vardikos. All rights reserved.
//

import UIKit

class RecordSoundsVC: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        statusLabel.text = "Recording in progress..."
        recordButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        statusLabel.text = "Tap to record"
        recordButton.isEnabled = true
        stopButton.isEnabled = false
    }
}

