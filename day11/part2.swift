import Foundation

var text = """
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
"""

do {
    text = try String(contentsOfFile: "day11.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}


var map = text.components(separatedBy: "\n").map { Array($0) }

var dots: [(Int,Int,Int,Int)] = [] 

for i in 0..<map.count {
    for j in 0..<map[i].count {
        if map[i][j] == "#" {
            dots.append((i,j,0,0))
        }
    }
}



var hr  = [Int]()
for i in 0..<map.count {
    var d = true
    for j in 0..<map[i].count { 
        if map[i][j] == "#" { d = false; break}
    }
    if d { hr.append(i) }
}

var vr  = [Int]()
for i in 0..<map.count {
    var d = true
    for j in 0..<map[i].count { 
        if map[j][i] == "#" { d = false; break}
    }
    if d { vr.append(i) }
}


for h in hr {
    for i in 0..<dots.count {
        if dots[i].0 > h { dots[i].2 += 999999 }
    }
}


for v in vr {
    for i in 0..<dots.count {
        if dots[i].1 > v { dots[i].3 += 999999 }
    }
}


var cnt = 0
let mult = 1

for i in 0..<dots.count - 1 {
    for j in i+1..<dots.count {
        let a = dots[i]
        let b = dots[j]
        cnt += abs((a.0 + a.2 * mult) - (b.0 + b.2 * mult)) + abs((a.1 + a.3 * mult) - (b.1 + b.3 * mult))
    }
}

print(cnt)
