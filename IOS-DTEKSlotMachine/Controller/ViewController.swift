//
//  ViewController.swift
//  IOS-DTEKSlotMachine
//
//  Created by Никита Порошин on 17.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.isUserInteractionEnabled = false
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.model.playSound(soundName: K.buttonPressedSound, fileType: "mp3" )
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.40, execute: {
            self.roll()
        })
        
    }
    
    func roll(){
        var delay : Double = 0
        
        for i in 0..<pickerView.numberOfComponents{
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                self.model.playSound(soundName: K.spinSound, fileType: "mp3")
                self.randomSelectRow(in: i)
            })
            delay += 0.30
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.checkResult()
        }
       
    }
    
    
    func randomSelectRow(in comp : Int){
        let r = Int(arc4random_uniform(UInt32(8 * Model.images.count))) + Model.images.count
        pickerView.selectRow(r, inComponent: comp, animated: true)
        
    }
    func checkResult(){
        var counter = 0.0
        for i in 0..<pickerView.numberOfComponents{
            let row : Int = pickerView.selectedRow(inComponent: i) % Model.images.count
            counter += model.countLight(row)
        }
        resultLabel.text = model.sumAllPoints(counter).0
        let soundName = model.sumAllPoints(counter).1
        DispatchQueue.main.asyncAfter(deadline: .now()+0.10, execute: {
            self.model.playSound(soundName: soundName, fileType: "wav")
        })
        
    }
}





//MARK: - UIPickerViewDataSource
extension ViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Model.images.count * 10
    }
    
    
}
//MARK: - UIPickerViewDelegate
extension ViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return UIImageView(image: Model.images[row % Model.images.count])
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Model.images[component % Model.images.count].size.height + 3
    }
    
}



