import Foundation

var text = """
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX
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

var starts = [String]()

for i in 2..<strs.count {
    let st = strs[i].components(separatedBy: " ")
    let d = Array(st[0])
    if d[2] == "A" { starts.append(st[0]) }
    map[st[0]] = (st[1],st[2])
}


var iS = starts.map { _ in return 0 } 

for j in 0..<starts.count {
    var start = starts[j]

    while start[start.index(start.startIndex, offsetBy: 2)] != "Z" {

        if let cn = map[start] {
        
        if instructions[iS[j] % instructions.count] == "L" { start = cn.0 }
        else { start = cn.1 }

        } else {
            print("XD")
            break
        }

        iS[j] += 1
    }

}

func nzs(_ numbers: [Int]) -> Int {
    func nzs(_ a: Int, _ b: Int) -> Int {
        return a * b / nzd(a, b)
    }
    
    func nzd(_ a: Int, _ b: Int) -> Int {
        var x = a
        var y = b
        while y != 0 {
            let temp = y
            y = x % y
            x = temp
        }
        return x
    }
    
    var rez = numbers[0]
    
    for num in numbers {
        rez = nzs(rez, num)
    }
    
    return rez
}

print(nzs(iS))