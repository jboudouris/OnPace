//
//  Home.swift
//  Watch Extension
//
//  Created by Neil Sekhon on 6/24/18.
//  Copyright © 2018 Mic Pringle. All rights reserved.
//

import Foundation
import WatchKit

class Home: WKInterfaceController {
  
    @IBOutlet var paceLabel: WKInterfaceLabel!
    
    var minutes = 10
    var seconds = 30
  
    override func awake(withContext context: Any?) {
			super.awake(withContext: context)
			
			
    }
	
	override func willActivate() {
		super.willActivate()
		
		if UserDefaults.standard.value(forKey: "minutes") != nil {
			minutes = UserDefaults.standard.integer(forKey: "minutes")
		}
		
		if UserDefaults.standard.value(forKey: "seconds") != nil {
			seconds = UserDefaults.standard.integer(forKey: "seconds")
		}
		
		paceLabel.setText("\(minutes): \(seconds)")
	}
  
}

