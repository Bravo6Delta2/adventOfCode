import Foundation

var text = ""

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
  
    for j in 0..<dd[i].count {
        let index = dd[i].index(dd[i].startIndex, offsetBy: j)
        let char = dd[i][index]
        if char.isNumber {
            if a == nil { a = Int("\(char)") } else { b = Int("\(char)") }
        }

    }

    guard let a1 = a else { continue }
    guard let b1 = b else { cnt += a1 * 10 + a1; continue }
    cnt += a1 * 10 + b1;
}
print(cnt)



