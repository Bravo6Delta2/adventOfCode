import Foundation


func calcDif(_ a: [Int]) -> [Int] {
    var b = [Int]()
    for i in 0..<a.count - 1 {
        b.append(a[i + 1] - a[i])
    }
    return b
}

func same(_ a: [Int]) -> Bool {
    var t = true
    for i in 0..<a.count - 1 {
        t = t && a[i] == a[i + 1] 
    }
    return t
} 

var text = """
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
"""

do {
    text = try String(contentsOfFile: "day9.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}

var nums: [[Int]] = []

for st in text.components(separatedBy: "\n") {
    nums.append([])
    for n in st.components(separatedBy: " ") {
        nums[nums.count - 1].append(Int(n) ?? 0)
    }
}

var cnt = 0

for num in nums {
    var d:[[Int]] = []
    d.append(num)
    d.append(calcDif(num))

    while !same(d[d.count - 1]) {
        d.append(calcDif(d[d.count - 1]))
    }

    var next = d[d.count - 1][0]

    for i in 2...d.count {
        next = next + d[d.count - i][d[d.count - i].count - 1]
    }

    cnt += next
}

print(cnt)