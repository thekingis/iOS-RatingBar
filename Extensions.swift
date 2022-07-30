//
//  Extensions.swift
//  RatingBarApp
//
//  Created by The KING on 30/07/2022.
//

import Foundation

extension Double {
    func roundUp(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension FloatingPoint {
    var whole: Self {
        modf(self).0
    }
    var fraction: Self {
        modf(self).1
    }
}
