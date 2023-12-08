import Foundation

var text = """
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
"""


do {
    text = try String(contentsOfFile: "day8.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}

text = text.replacingOccurrences(of: " ", with: "")
text = text.replacingOccurrences(of: "=", with: "")
text = text.replacingOccurrences(of: "(", with: " ")
text = text.replacingOccurrences(of: ",", with: " ")
text = text.replacingOccurrences(of: ")", with: "")

var strs = text.components(separatedBy: "\n")

let instructions = Array(strs[0])

var map: [String: (String,String)] = [:]

for i in 2..<strs.count {
    let st = strs[i].components(separatedBy: " ")
    map[st[0]] = (st[1],st[2])
}

var start = "AAA"
var i = 0

while start != "ZZZ" {

    if let cn = map[start] {
        
        if instructions[i % instructions.count] == "L" { start = cn.0 }
        else { start = cn.1 }

    } else {
        print("XD")
        break
    }

    i += 1
}


print(i)