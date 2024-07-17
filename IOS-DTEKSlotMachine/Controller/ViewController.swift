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
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
    }
    
    
}
//MARK: - UIPickerViewDataSource
extension ViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.images.count * 10
    }
}
//MARK: - UIPickerViewDelegate
extension ViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return UIImageView(image: model.images[row % model.images.count])
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return model.images[component % model.images.count].size.height + 1
    }
}


