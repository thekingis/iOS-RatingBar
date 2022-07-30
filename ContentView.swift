//
//  ContentView.swift
//  RatingBarApp
//
//  Created by The KING on 30/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var rating: Double = 0
    let maxRating = 5
    @State var rate = "0"
    
    var body: some View {
        ZStack {
            Colors.white
            VStack {
                Text(rate)
                    .foregroundColor(Colors.black)
                RatingBar(rating: $rating, maxRating: maxRating)
                Button {
                    rate = String(rating)
                } label: {
                    ZStack {
                        Text("Rate")
                            .foregroundColor(Colors.white)
                            .padding(10)
                    }
                    .background(Colors.red)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                }

            }
        }
    }
}
