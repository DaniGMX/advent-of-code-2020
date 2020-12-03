//
//  day_two.swift
//  advent of code 2020
//
//  Created by Daniel Alexander Gracia Machado on 02/12/2020.
//

import Foundation

struct Password {
    var firstNum: Int
    var secondNum: Int
    var char: Character
    var password: String
    
    init(min: Int, max: Int, character: Character, password: String) {
        self.firstNum = min
        self.secondNum = max
        self.char = character
        self.password = password
    }
}

func dayTwoPartOne() -> Int {
    let passwords = parseDayTwoInputs()
    var count = 0
        
    for password in passwords {
        let occursOfChar = password.password.count(of: password.char)
        if (occursOfChar >= password.firstNum && occursOfChar <= password.secondNum) {
            count += 1
        }
    }
    
    return count
}

func dayTwoPartTwo() -> Int {
    let passwords = parseDayTwoInputs()
    var count = 0
    
    for password in passwords {
        let charAtFirstNum: Character = password.password.charAt(index: password.firstNum - 1)
        let charAtSecondNum: Character = password.password.charAt(index: password.secondNum - 1)
        
        if ((charAtFirstNum == password.char && charAtSecondNum != password.char) ||
            (charAtFirstNum != password.char && charAtSecondNum == password.char)) {
            count += 1
        }
    }
    
    return count
}

extension String {
    func count(of needle: Character) -> Int {
        return reduce(0) {
            $1 == needle ? $0 + 1 : $0
        }
    }
}

extension String {
    func charAt(index: Int) -> Character {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur += 1
        }
        return " "
    }
}

func parseDayTwoInputs() -> Array<Password> {
    var passwords: Array<Password> = Array()
    let file: String = "day_two.txt"
    var contents: String = ""
    
    
    if let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)
        do {
            contents = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = contents.split(separator: "\n")
            var min: Int = 0
            var max: Int = 0
            var char: Character = " "
            var pass: String = ""
            for line in lines {
                let params = line.split(separator: " ")
                
                for i in 0 ..< params.count {
                    if (i == 0) {
                        let range = params[i].split(separator: "-")
                        min = Int(range[0])!
                        max = Int(range[1])!
                    }
                    if (i == 1) {
                        char = Character(params[i].replacingOccurrences(of: ":", with: ""))
                    }
                    if (i == 2) {
                        pass = String(params[i])
                    }
                }
                passwords.append(Password(min: min, max: max, character: char, password: pass))
            }
        }
        catch {
            print("err")
        }
    }
    
    return passwords
}
