import Foundation

func numOfSpec(_ a: inout [String.Element], _ i: Int, _ b: inout [Int], _ pattern: inout String) -> Int {
    if i == a.count {
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: a.count)
        
        if let _ = regex.firstMatch(in: String(a), options: [], range: range) {
            return 1
        }
    
        return 0
    }

    if a[i] == "?" {
        a[i] = "0"
        let r = numOfSpec(&a, i + 1, &b, &pattern)
        a[i] = "1"
        let r1 = numOfSpec(&a, i + 1, &b, &pattern)
        a[i] = "?"
        return r + r1
    }

    return numOfSpec(&a, i + 1, &b, &pattern)
}


var text = """
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
"""

// do {
//     text = try String(contentsOfFile: "day12.txt")
// } catch {
//     print("Error reading contents: \(error.localizedDescription)")
// }

text = text.replacingOccurrences(of: ".", with: "0")
text = text.replacingOccurrences(of: "#", with: "1")

let strs = text.components(separatedBy: "\n")

var codes:[[String.Element]] = []
var nums: [[Int]] = []

strs.map {
    let str = $0.components(separatedBy: " ")
    codes.append(Array(str[0]))
    let d = str[1].components(separatedBy: ",").map { st in
        Int(st) ?? -1
    }
    nums.append(d)
}

var cnt = 0

for i in 0..<codes.count {
    
    var pattern = "^0*"

    for bi in 0..<nums[i].count {
        pattern.append(contentsOf: "1{\(nums[i][bi])}")
        bi == nums[i].count - 1 ? pattern.append(contentsOf: "0*$") : pattern.append(contentsOf: "0+")
    }
    let k = numOfSpec(&codes[i], 0, &nums[i], &pattern) 
    print(k)
    cnt += k
}

print(cnt)
