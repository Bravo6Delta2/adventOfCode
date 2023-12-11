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

let adder = map[hr[0]]
var pl = 0
for h in hr {
   map.insert(adder, at: h + pl)
   pl += 1
}

pl = 0
for v in vr {
    for i in 0..<map.count {
        map[i].insert(".", at: v + pl)
    }
    pl += 1
}

var dots: [(Int,Int)] = [] 

for i in 0..<map.count {
    for j in 0..<map[i].count {
        if map[i][j] == "#" {
            dots.append((i,j))
        }
    }
}

var cnt = 0

for i in 0..<dots.count - 1 {
    for j in i+1..<dots.count {
        let a = dots[i]
        let b = dots[j]
        cnt += abs(a.0 - b.0) + abs(a.1 - b.1)
    }
}

print(cnt)
