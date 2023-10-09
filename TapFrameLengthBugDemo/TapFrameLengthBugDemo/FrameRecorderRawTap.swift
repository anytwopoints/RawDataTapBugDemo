//
//  FrameRecorderRawTap.swift
//  TapFrameLengthBugDemo
//
//  Created by Neil Wells on 09/10/2023.
//

import Foundation
import AudioKit
import AVFAudio

class FrameRecorderRawTap : RawDataTap {
    
    var previousBlockStart : Int64?
    
    override func doHandleTapBlock(buffer: AVAudioPCMBuffer, at time: AVAudioTime) {
        
        
        
        buffer.frameLength = self.bufferSize // This is just to show that setting the buffer framelength here does not solve the issue
        
        if let previousBlockStart = previousBlockStart {
            
            print("Frames since previous tap block \(time.sampleTime - previousBlockStart) ")
            
        }
        
        self.previousBlockStart = time.sampleTime
        
        super.doHandleTapBlock(buffer: buffer, at: time)
        
        
    }
    
    
    
    
}
