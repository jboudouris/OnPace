//
//  RunDisplay.swift
//  Watch Extension
//
//  Created by Ethan Young on 6/24/18.
//  Copyright © 2018 Mic Pringle. All rights reserved.
//

import Foundation
import WatchKit
import CoreLocation

private let locationManager = LocationManager.shared
private var seconds = 0
private var timer: Timer?
private var distance = Measurement(value: 0, unit: UnitLength.meters)
private var locationList: [CLLocation] = []

class RunDisplay: WKInterfaceController {
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
    locationManager.stopUpdatingLocation()
  }
  
  private func startRun() {
//    launchPromptStackView.isHidden = true
//    dataStackView.isHidden = false
//    startButton.isHidden = true
//    stopButton.isHidden = false
    
    seconds = 0
    distance = Measurement(value: 0, unit: UnitLength.meters)
    locationList.removeAll()
    updateDisplay()
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
      self.eachSecond()
    }
    startLocationUpdates()
  }
  
  private func stopRun() {
//    launchPromptStackView.isHidden = false
//    dataStackView.isHidden = true
//    startButton.isHidden = false
//    stopButton.isHidden = true
    
    locationManager.stopUpdatingLocation()
  }
  
  private func saveRun() {
    let newRun = Run(context: CoreDataStack.context)
    newRun.distance = distance.value
    newRun.duration = Int16(seconds)
    newRun.timestamp = Date()
    
    for location in locationList {
      let locationObject = Location(context: CoreDataStack.context)
      locationObject.timestamp = location.timestamp
      locationObject.latitude = location.coordinate.latitude
      locationObject.longitude = location.coordinate.longitude
      newRun.addToLocations(locationObject)
    }
    
    CoreDataStack.saveContext()
    
    run = newRun
  }
  
  // Need to have to stop run when stop is clicked
//  alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
//  self.stopRun()
//  self.saveRun() // ADD THIS LINE!
//  self.performSegue(withIdentifier: .details, sender: nil)
//  })
  
  func eachSecond() {
    seconds += 1
    updateDisplay()
  }
  
  private func updateDisplay() {
    let formattedDistance = FormatDisplay.distance(distance)
//    let formattedTime = FormatDisplay.time(seconds)
//    let formattedPace = FormatDisplay.pace(distance: distance,
//                                           seconds: seconds,
//                                           outputUnit: UnitSpeed.minutesPerMile)
//
//    distanceLabel.text = "Distance:  \(formattedDistance)"
//    timeLabel.text = "Time:  \(formattedTime)"
//    paceLabel.text = "Pace:  \(formattedPace)"
  }
  
  private func startLocationUpdates() {
    locationManager.delegate = self
    locationManager.activityType = .fitness
    locationManager.distanceFilter = 10
    locationManager.startUpdatingLocation()
  }
}

extension NewRunViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    for newLocation in locations {
      let howRecent = newLocation.timestamp.timeIntervalSinceNow
      guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
      
      if let lastLocation = locationList.last {
        let delta = newLocation.distance(from: lastLocation)
        distance = distance + Measurement(value: delta, unit: UnitLength.meters)
      }
      
      locationList.append(newLocation)
    }
  }
}
