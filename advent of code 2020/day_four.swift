//
//  day_four.swift
//  advent of code 2020
//
//  Created by Daniel Alexander Gracia Machado on 04/12/2020.
//

import Foundation

func dayFourPartOne() -> Int {
    let passports: [[String:String]] = parseDayFourInputs()
    var validPassportCount = 0
    let requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    
    for passport in passports {
        if (passport.containsRequiredKeys(requiredKeys: requiredFields)) {
            validPassportCount += 1
        }
    }
    return validPassportCount
}

func dayFourPartTwo() -> Int {
    let passports: [[String:String]] = parseDayFourInputs()
    var validPassportCount = 0
    let requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    for passport in passports {
        var validCount = 0
        if (!passport.containsRequiredKeys(requiredKeys: requiredFields)) {
            continue
        }
        for requiredField in requiredFields {
            switch requiredField {
            case "byr":
                let birthYear: Int = Int(passport[requiredField]!)!
                if (1920 ... 2002 ~= birthYear) {
                    print("\(requiredField) : \(birthYear)")
                    validCount += 1
                }
            case "iyr":
                let issueYear: Int = Int(passport[requiredField]!)!
                if (2010 ... 2020 ~= issueYear) {
                    print("\(requiredField) : \(issueYear)")
                    validCount += 1
                }
            case "eyr":
                let expirationYear: Int = Int(passport[requiredField]!)!
                if (2020 ... 2030 ~= expirationYear) {
                    print("\(requiredField) : \(expirationYear)")
                    validCount += 1
                }
            case "hgt":
                let rawHeight = passport[requiredField]!
                let units: String = rawHeight.trimmingCharacters(in: .decimalDigits)
                let size: Int = Int(rawHeight.trimmingCharacters(in: .letters))!
                let cmOk: Bool = units == "cm" && 150 ... 193 ~= size
                let inOk: Bool = units == "in" && 59 ... 76 ~= size
                if (cmOk || inOk) {
                    print("\(requiredField) : \(rawHeight)")
                    validCount += 1
                }
            case "hcl":
                let hexHairColor: String = passport[requiredField]!
                let startsInHash: Bool = hexHairColor.charAt(index: 0) == "#"
                if (startsInHash) {
                    let value: String = passport[requiredField]!.trimmingCharacters(in: .symbols)
                    var validCharCount = 0
                    for char in value {
                        if ("0" ... "9" ~= char || "a" ... "f" ~= char) {
                            validCharCount += 1
                        }
                    }
                    if (validCharCount == 6) {
                        print("\(requiredField) : \(hexHairColor)")
                        validCount += 1
                    }
                }
            case "ecl":
                let eyeColor: String = passport[requiredField]!
                let validEyeColors: [String] = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
                if (validEyeColors.contains(eyeColor)) {
                    print("\(requiredField) : \(eyeColor)")
                    validCount += 1
                }
            case "pid":
                let rawPasswordID: String = passport[requiredField]!
                if (rawPasswordID.count == 9) {
                    print("\(requiredField) : \(rawPasswordID)")
                    validCount += 1
                }
            default:
                print("err")
            }
        }
        if (validCount == 7) {
            validPassportCount += 1
            print("Valid! Currently \(validPassportCount) valid passports")
        }
        print("\n")
    }
    return validPassportCount
}

func parseDayFourInputs() -> [[String:String]] {
    var passports: [[String:String]] = []
//    let requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    let file: String = "day_four.txt"
    
    if let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)
        do {
            let contents = try String(contentsOf: fileURL, encoding: .utf8)
            let rawPassportData = contents.components(separatedBy: "\n\n")
            for rawPassport in rawPassportData {
                let rawPassportFieldsLines = rawPassport.components(separatedBy: "\n")
                var rawPassportFields: [String] = []
                var fields: [String] = []
                var passport = [String:String]()
                for rawPassportFieldsLine in rawPassportFieldsLines {
                    fields.append(contentsOf: rawPassportFieldsLine.components(separatedBy: " "))
                    rawPassportFields.append(contentsOf: fields)
                }
                for field in fields {
                    let keyVal = field.components(separatedBy: ":")
                    if (keyVal.count != 2) {
                        continue
                    }
                    passport[keyVal[0]] = keyVal[1]
                }
                passports.append(passport)
            }
        }
        catch {
            print("err")
        }
    }
    
    return passports
}

extension Dictionary where Key == String, Value == String {
    func containsRequiredKeys(requiredKeys: [String]) -> Bool {
        var valid = true
        for key in requiredKeys {
            if (self[key] == nil) {
                valid = false
                break
            }
        }
        return valid
    }
}
