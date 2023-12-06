import Foundation

var text = """
Time:        46     68     98     66
Distance:   358   1054   1807   1080
"""

let strs = text.components(separatedBy: "\n")

let time = strs[0].components(separatedBy: " ").filter { $0 != "" }.dropFirst().map{Int($0) ?? 0}
let dst = strs[1].components(separatedBy: " ").filter { $0 != "" }.dropFirst().map{Int($0) ?? 0}

var final = 1
for i in 0..<time.count {
    var cnt = 0
    for j in 1..<time[i] {
        if j * (time[i] - j)  > dst[i] { cnt += 1 }
    }
    final *= cnt
}

print(final)