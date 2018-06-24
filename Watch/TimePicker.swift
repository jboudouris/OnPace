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
  
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    print("shown")
  }
  
}
