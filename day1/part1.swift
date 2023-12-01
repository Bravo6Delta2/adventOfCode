import Foundation

let text = ""

do {
    text = try String(contentsOfFile: "day1.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}

var cnt = 0
var dd = text.components(separatedBy: "\n")
for i in 0..<dd.count {
    var a: Int? = nil
    var b: Int? = nil
    var str = ""
    for j in 0..<dd[i].count {
        let index = dd[i].index(dd[i].startIndex, offsetBy: j)
        let char = dd[i][index]
        if char.isNumber {
            if a == nil { a = Int("\(char)") } else { b = Int("\(char)") }
            str = ""
        }

        str = "\(str)\(char)"

        if str.contains("one") {
            if a == nil { a = 1 } else { b = 1 }
            str = "\(char)"
        }
        if str.contains("two") {
            if a == nil { a = 2 } else { b = 2 }
            str = "\(char)"
        }
        if str.contains("three") {
            if a == nil { a = 3 } else { b = 3 }
            str = "\(char)"
        }
        if str.contains("four") {
            if a == nil { a = 4 } else { b = 4 }
            str = "\(char)"
        }
        if str.contains("five") {
            if a == nil { a = 5 } else { b = 5 }
            str = "\(char)"
        }
        if str.contains("six") {
            if a == nil { a = 6 } else { b = 6 }
            str = "\(char)"
        }
        if str.contains("seven") {
            if a == nil { a = 7 } else { b = 7 }
            str = "\(char)"
        }
        if str.contains("eight") {
            if a == nil { a = 8 } else { b = 8 }
            str = "\(char)"
        }
        if str.contains("nine") {
            if a == nil { a = 9 } else { b = 9 }
            str = "\(char)"
        }
    }
    
    guard let a1 = a else { continue }
    guard let b1 = b else { cnt += a1 * 10 + a1; continue }
    cnt += a1 * 10 + b1;
}
print(cnt)