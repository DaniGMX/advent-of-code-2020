//
//  day_five.swift
//  advent of code 2020
//
//  Created by Daniel Alexander Gracia Machado on 05/12/2020.
//

import Foundation

func dayFivePartOne() -> [Int] {
    let guides: [String] = pareseDayFiveInputs()
    var seats: [Int] = []
    var biggestID = 0
    
    for seatGuide in guides {
        var seatRow = [0, 127]
        var seatCol = [0, 7]
        var currentID = 0
        for move in seatGuide {
            let midRow = (seatRow[0] + seatRow[1]) / 2
            let midCol = (seatCol[0] + seatCol[1]) / 2

            if (move == "B") {  // upper half
                seatRow[0] = midRow + 1
            }
            if (move == "F") {  // lower half
                seatRow[1] = midRow
            }
            if (move == "R") {  // upper half
                seatCol[0] = midCol + 1
            }
            if (move == "L") {  // lower half
                seatCol[1] = midCol
            }
        }
        currentID = seatRow[0] * 8 + seatCol[0]
        if (currentID > biggestID) {
            biggestID = currentID
        }
        seats.append(currentID)
    }
    
    seats.sort()
    
    return seats
}

func dayFivePartTwo() -> Int {
    let seats = dayFivePartOne()
    var index = 48
    var seat = 0
    
    for i in 0 ..< seats.count {
        if (index != seats[i]) {
            seat = index
            break
        }
        index += 1
    }
    
    return seat
}

func pareseDayFiveInputs() -> [String] {
    var inputs: [String] = []
    let file = "day_five.txt"
    var contents = ""
    
    if let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)
        do {
            contents = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = contents.split(separator: "\n")
            for str in lines {
                inputs.append(String(str))
            }
        }
        catch {
            print("err")
        }
    }
    
    return inputs
}
