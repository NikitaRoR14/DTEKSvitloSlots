//
//  Model.swift
//  IOS-DTEKSlotMachine
//
//  Created by Никита Порошин on 17.07.2024.
//

import Foundation
import UIKit
import AVFoundation

struct Model{
    static let images = [#imageLiteral(resourceName: "LightOn"),  #imageLiteral(resourceName: "PossibleLight") ,  #imageLiteral(resourceName: "NoLight")]
    
    var audioPlayer = AVAudioPlayer()
    
    
    mutating func playSound(soundName:String,fileType:String) {
        guard let path = Bundle.main.path(forResource: "\(soundName)", ofType:"\(fileType)") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func countLight(_ row:Int) ->Double {
        let image = Model.images[row]
        var result:Double = 0.0
        switch image.description{
        case K.lightOnImage:
            result = 1.0
        case K.noLightImage:
            result = 0.0
        
        case K.possibleLightImage:
            result = 0.5
        default:
            print("error img desc")
        }
        return result
    }
     func sumAllPoints(_ counter:Double) -> (String,String){
        var resultMessage = ""
        var soundName = ""
        switch counter{
        case 0.0..<1.5:
            resultMessage = K.noElectricity.randomElement()!
            soundName = K.noLightSound
        case 1.5:
            resultMessage = K.electricityPossible.randomElement()!
            soundName = K.possibleLightSound
        case 1.6...:
            resultMessage = K.electricityOn.randomElement()!
            soundName = K.lightOnSound
        default:
            print("error result message")
        }
        return (resultMessage,soundName)
    }
}

