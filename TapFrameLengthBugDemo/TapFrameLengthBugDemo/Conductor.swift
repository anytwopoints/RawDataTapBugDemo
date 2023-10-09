//
//  Conductor.swift
//  TapFrameLengthBugDemo
//
//  Created by Neil Wells on 09/10/2023.
//

import Foundation
import AudioKit
import AVFAudio

class Conductor {
    
    static let sharedInstance = Conductor()
    
    var audioEngine = AudioEngine()
    var mixer : Mixer
    var tap : FrameRecorderRawTap?
    
    
    
    func startMicAndTap() {
        
        
        
        if let  inputs = Settings.session.availableInputs {
        
            if let builtInMic =  inputs.first(where: { $0.portType == .builtInMic  }) {
               
                do { try Settings.session.setPreferredInput(builtInMic)
                    try  Settings.session.setActive(true)
                }
                catch { fatalError("unable to set mic input") }
            }
            
        }
        
        guard let input = audioEngine.input else { fatalError("unable to find mic") }
       
        mixer.addInput(input)
        
        audioEngine.output = mixer
     
        
        
        do { try audioEngine.start() } catch { fatalError("unable to start audio engine") }
      
    
      
        tap = FrameRecorderRawTap(mixer, callbackQueue: DispatchQueue.global(qos: .default))
        tap?.start()
        
        // Uncomment below and comment out two lines above installation to demonstrate issue.
        
        /*
        
         
           let bufferSize : UInt32 = 256
          
           var timeS : Int64 = 0   // counter variable for AVAudiotime
         
        mixer.avAudioNode.installTap(onBus: 0, bufferSize: bufferSize, format: nil, block: { (buffer, time) in
        
           //  If the buffer frame length is not set using the line below, the AVAudiotime progresses by 4410 frames (which I assume is the frame capacity. If the framelength is set, the tap behaves as expected.
             
           // buffer.frameLength = bufferSize
            
            print("Frames since previous block execution using AVAudioNode tap \(time.sampleTime - timeS)")
            timeS = time.sampleTime
            
        })
         
         */
      
        

    }
    
    init() {
        
        self.mixer = Mixer()
       
        
        
        
        
    }
    
    
    
    
    
}
