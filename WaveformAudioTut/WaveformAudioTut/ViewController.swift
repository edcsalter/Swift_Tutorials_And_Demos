//
//  ViewController.swift
//  WaveformAudioTut
//
//  Created by Edward Salter on 10/25/14.
//  Copyright (c) 2014 Ed Salter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AVAudioSessionDelegate, AVAudioRecorderDelegate, EZMicrophoneDelegate  {
    private let audioSession = AVAudioSession.sharedInstance()
    private var microphone: EZMicrophone?
    private var recorder: AVAudioRecorder?
    
    @IBOutlet weak var waveformDrawing: EZAudioPlotGL!
    @IBOutlet weak var labelAvgLevel: UILabel!
    @IBOutlet weak var labelMaxLevel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabels()
        self.setupPlotAndMic()
        self.setupAudioSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupLabels() {
        self.labelAvgLevel.textAlignment = .Center
        self.labelAvgLevel.textColor = UIColor.blackColor()
        self.view.addSubview(labelAvgLevel)
        
        self.labelMaxLevel.textAlignment = .Center
        self.labelMaxLevel.textColor = UIColor.blackColor()
        self.view.addSubview(labelMaxLevel)
        
    }

    func setupPlotAndMic() {
        let bgColor = UIColor(red: 0.4, green: 0.2, blue: 0.6, alpha:1.0)
        let plotColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.waveformDrawing.backgroundColor = bgColor
        self.waveformDrawing.color = plotColor
        self.waveformDrawing.plotType = EZPlotType.Rolling
        self.waveformDrawing.shouldFill = false
        self.waveformDrawing.shouldMirror = true
        self.microphone = EZMicrophone()
        self.microphone!.microphoneDelegate = self
        self.microphone!.startFetchingAudio()
    }
    
    func setupAudioSession() {
        var error: NSError?
        
        let urlSink = NSURL(fileURLWithPath: "/dev/null")
        
        let recorderSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : kAudioConverterCodecQuality,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        
        self.recorder = AVAudioRecorder(URL: urlSink, settings: recorderSettings, error: &error)
        if error != nil {
            println(error?.localizedDescription)
        }
        
        if (audioSession.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("granted")

                    self.audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
                    if error != nil {
                        println(error?.localizedDescription)
                    }
                    
                    self.audioSession.setActive(true, error: &error)
                    if error != nil {
                        println(error?.localizedDescription)
                    }
                    
                    self.recorder!.meteringEnabled = true
                    self.recorder!.record()
                } else {
                    println("not granted")
                }
            })
        }
    }
    
    func updateLabels() {
        self.recorder!.updateMeters()
        
        var avgLvl = Int(self.recorder!.averagePowerForChannel(0))
        self.labelAvgLevel.text = String("\(avgLvl + 80)")
        
        var maxLvl = Int(self.recorder!.peakPowerForChannel(0))
        self.labelMaxLevel.text = String("\(maxLvl + 80)")
    }
    
    func microphone(microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.updateLabels()
            self.waveformDrawing.updateBuffer(buffer[0], withBufferSize: bufferSize)
        })
    }
    
    func microphone(microphone: EZMicrophone!, hasAudioStreamBasicDescription audioStreamBasicDescription: AudioStreamBasicDescription) {
        println("\(EZAudio.printASBD(audioStreamBasicDescription))")
    }
    
//    func microphone(microphone: EZMicrophone!, hasBufferList bufferList: UnsafeMutablePointer<AudioBufferList>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
//    }
}

