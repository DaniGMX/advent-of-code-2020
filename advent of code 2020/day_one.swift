//
//  day_one.swift
//  advent of code 2020
//
//  Created by Daniel Alexander Gracia Machado on 02/12/2020.
//

import Foundation

func dayOnePartOne() -> Int {
    let nums = parsedDayOneInput()
    let target = 2020
    
    var ret: Int = 0
    var dict = [Int:Int]()
    
    for i in 0 ..< nums.count {
        let comp = target - nums[i]
        
        if dict.keys.contains(comp) && dict[comp]! != i {
            //print("\(nums[i]), \(rem)")
            ret = nums[i] * comp;
            break;
        }
        dict[nums[i]] = i
    }
    
    return ret
}

func dayOnePartTwo() -> Int {
    var nums = parsedDayOneInput()
    let target = 2020
    
    //var dict = [Int:Int]()
    nums.sort {
        $0 < $1
    }
    for i in 0 ..< nums.count {
        var left = i + 1
        var right = nums.count - 1
        
        while left < right {
            if nums[i] + nums[left] + nums[right] == target {
                return nums[i] * nums[left] * nums[right]
            } else if (nums[i] + nums[left] + nums[right] < target) {
                left += 1;
            } else {
                right -= 1;
            }
        }
    }
    
    return 0
}

func parsedDayOneInput() -> Array<Int> {
    var arr: Array<Int> = Array()
    let file = "day_one.txt"
    var contents = ""
    
    if let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)
        do {
            contents = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = contents.split(separator: "\n")
            for str in lines {
                let num = Int(str)
                arr.append(num!)
            }
        }
        catch {
            print("err")
        }
    }
    
    return arr
}
