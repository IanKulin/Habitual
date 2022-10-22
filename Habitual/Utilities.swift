//
//  Utilities.swift
//  Habitual
//
//  Created by Ian Bailey on 19/10/2022.
//

import Foundation


func dueString(_ interval: TimeInterval) -> String {
    let day = 86_400.0
    switch interval {
    case 0..<day:
        return "due today"
    case day..<day * 2:
        return "due tomorow"
    default:
        return "default"
    }
}
