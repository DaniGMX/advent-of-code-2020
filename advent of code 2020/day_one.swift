//
//  day_one.swift
//  advent of code 2020
//
//  Created by Daniel Alexander Gracia Machado on 02/12/2020.
//

import Foundation

func dayOne() -> Int {
    let nums = parsedDayOneInput()
    let target = 2020
    
    var ret: Int = 0
    var dict = [Int:Int]()
    
    for i in 0 ..< nums.count {
        let rem = target - nums[i]
        
        if dict.keys.contains(rem) && dict[rem]! != i {
            print("\(nums[i]), \(rem)")
            ret = nums[i] * rem;
            break;
        }
        dict[nums[i]] = i
    }
    
    return ret
}

func parsedDayOneInput() -> Array<Int> {
    var arr: Array<Int> = Array()
    let file = "day_one.txt"
    var result = ""
    
    if let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)
        do {
            result = try String(contentsOf: fileURL, encoding: .utf8)
            let resultsArr = result.split(separator: "\n")
            for str in resultsArr {
                let num = Int(str)
                arr.append(num!)
            }
            //print(arr)
        }
        catch {
            print("err")
        }

    }
    
    return arr
}
