//
//  Model.swift
//  IOS-DTEKSlotMachine
//
//  Created by Никита Порошин on 17.07.2024.
//

import Foundation
import UIKit


struct Model{
    let images = [#imageLiteral(resourceName: "PossibleLight") , #imageLiteral(resourceName: "LightOn"), #imageLiteral(resourceName: "NoLight")]
    
    func countLight(_ row:Int) ->Int {
        let image = images[row]
        switch image.description{
            
        default:
            //
        }
    }
}

