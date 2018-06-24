//
//  TimePicker.swift
//  AirAber
//
//  Created by Neil Sekhon on 6/24/18.
//  Copyright © 2018 Mic Pringle. All rights reserved.
//

import Foundation
import WatchKit

class TimePicker : WKInterfaceController {
  
    var minutes = Int()
    var seconds = Int()
  
    @IBOutlet var minutePicker: WKInterfacePicker!
    @IBOutlet var secondPicker: WKInterfacePicker!
    
    @IBOutlet var setButton: WKInterfaceButton!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    
        var items = [WKPickerItem]()
        for i in 0...12 {
            items.append(makePickerItem(num: i))
        }
        
        minutePicker.setItems(items)
        
        var secondItems = [WKPickerItem]()
        for i in 0...59 {
            secondItems.append(makePickerItem(num: i))
        }
        
        secondPicker.setItems(secondItems)
    }
    
    func makePickerItem(num: Int) -> WKPickerItem {
        let item = WKPickerItem()
        item.title = String(num)
        
        return item
    }
    
    @IBAction func setPressed() {
        self.dismiss()
    }
    
    @IBAction func pickerChanged(_ value: Int) {
				UserDefaults.standard.set(value, forKey: "minutes")
    }
	
	@IBAction func secondPickerChanged(_ value: Int) {
		UserDefaults.standard.set(value, forKey: "seconds")
	}
	
}
