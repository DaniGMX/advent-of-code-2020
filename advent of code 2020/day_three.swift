//
//  day_three.swift
//  advent of code 2020
//
//  Created by Daniel Alexander Gracia Machado on 03/12/2020.
//

import Foundation

func dayThreePartOne(step: [Int]) -> Int {
    let forest: [[Character]] = parseDayThreeInputs()
    let forestWidth: Int = forest[0].count
    let tree: Character = "#"

    var y = 0
    var x = 0
    var count: Int = 0
    
    while y < forest.count {
        if (forest[y][x] == tree) {
            count += 1
        }
        y += step[0]
        x += step[1]
        x %= forestWidth
    }
    
    return count
}

func dayThreePartTwo() -> Int {
    var ret = 1
    
    let steps: [[Int]] = [
        [ 1, 1 ],
        [ 1, 3 ],
        [ 1, 5 ],
        [ 1, 7 ],
        [ 2, 1 ]
    ]
    
    for i in 0 ..< 5 {
        ret *= dayThreePartOne(step: steps[i])
    }
        
    return ret
}

func parseDayThreeInputs() -> [[Character]] {
    var rows: [[Character]] = []
    let file: String = "day_three.txt"
    
    if let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)
        do {
            let contents = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = contents.split(separator: "\n")
            for line in lines {
                rows.append(Array(line))
            }
        }
        catch {
            print("err")
        }
    }
    
    return rows
}
