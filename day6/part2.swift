import Foundation

var text = """
Time:        46     68     98     66
Distance:   358   1054   1807   1080
"""

let strs = text.components(separatedBy: "\n")

let time = strs[0].components(separatedBy: " ").filter { $0 != "" }.dropFirst().map{Int($0) ?? 0}.reduce("") { result, element in "\(result)\(element)" }
let dst = strs[1].components(separatedBy: " ").filter { $0 != "" }.dropFirst().map{Int($0) ?? 0}.reduce("") { result, element in "\(result)\(element)" }


let t = Int(time) ?? 0
let d = Int(dst) ?? 0


var cnt = 0

for j in 1..<t {
    if j * (t - j) > d { cnt += 1 }
}



print(cnt)