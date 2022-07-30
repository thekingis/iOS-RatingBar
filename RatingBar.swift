//
//  RatingBar.swift
//  RatingBarApp
//
//  Created by The KING on 30/07/2022.
//

import SwiftUI

struct RatingBar: View {
    
    @Binding var rating: Double
    let maxRating: Int
    let fullStar = "star.fill"
    let halfStar = "star.leadinghalf.filled"
    let offColor = Colors.grey
    let onColor = Colors.gold
    @State private var imageSet: [[Any]] = []
    
    var body: some View {
        HStack(spacing: 0){
            if imageSet.count > 0 {
                ForEach(0..<maxRating, id: \.self){ number in
                    let imgSet = getImageSet(number)
                    let star = imgSet[0] as! String
                    let isOnColor = imgSet[1] as! Bool
                    Image(systemName: star)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(isOnColor ? onColor : offColor)
                        .padding(.horizontal, 5)
                        .onTapGesture {
                            rating = Double(number + 1)
                            let iSet: [Any] = [fullStar, true]
                            setImageSet(number, iSet)
                        }
                }
            }
        }
        .coordinateSpace(name: "hStack")
        .gesture(
            DragGesture(minimumDistance: 10, coordinateSpace: .named("hStack"))
                .onChanged { gesture in
                    let gestureX = Int(gesture.location.x)
                    readGesture(gestureX: gestureX)
                }
        )
        .onAppear(){
            insertImageSet()
        }
    }
    
    func readGesture(gestureX: Int){
        let hStackWidth = maxRating * 40
        if gestureX < 0 {
            let imgSet: [Any] = [fullStar, false]
            setImageSet(0, imgSet)
            rating = 0
        } else if gestureX > hStackWidth {
            let lastIndex = maxRating - 1
            let imgSet: [Any] = [fullStar, true]
            setImageSet(lastIndex, imgSet)
            rating = Double(maxRating)
        } else {
            let gestureXD = Double(gestureX)
            let hStackWidthD = Double(hStackWidth)
            let progress = (gestureXD / hStackWidthD) * Double(maxRating)
            rating = toNearest(progress.roundUp(to: 2), 0.5)
            let index = Int(rating.whole)
            let fraction = rating.fraction
            let isHalf = fraction > 0
            if rating == 0 {
                let imgSet: [Any] = [fullStar, false]
                setImageSet(0, imgSet)
                return
            }
            if index == maxRating {
                let lastIndex = maxRating - 1
                let imgSet: [Any] = [fullStar, true]
                setImageSet(lastIndex, imgSet)
                return
            }
            let star = isHalf ? halfStar : fullStar
            let imgSet: [Any] = [star, isHalf]
            setImageSet(index, imgSet)
        }
    }
    
    func toNearest(_ value: Double, _ nearest: Double) -> Double {
        return round(value / nearest) * nearest
    }
    
    func insertImageSet(){
        var imageSetInit: [[Any]] = []
        for _ in 0..<maxRating {
            let imgSet: [Any] = [fullStar, false]
            imageSetInit.append(imgSet)
        }
        self.imageSet = imageSetInit
    }
    
    func setImageSet(_ i: Int, _ imgSet: [Any]) {
        imageSet[i] = imgSet
        if i > 0 {
            for x in 0..<i {
                let iSet: [Any] = [fullStar, true]
                imageSet[x] = iSet
            }
        }
        if i < maxRating {
            let a = i + 1
            for x in a..<maxRating {
                let iSet: [Any] = [fullStar, false]
                imageSet[x] = iSet
            }
        }
    }
    
    func getImageSet(_ i: Int) -> [Any] {
        return imageSet[i]
    }
    
}
