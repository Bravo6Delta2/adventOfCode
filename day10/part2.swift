import Foundation

func findStart(_ map: [[String.Element]]) -> (Int, Int) {
    for i in 0..<map.count {
        for j in 0..<map[i].count {
            if map[i][j] == "S" { return (i,j) }
        }
    }
    return (0,0)
}

func charMove (_ map: [[String.Element]], _ i: Int, _ j: Int) -> [(Int,Int)] {
    let c = map[i][j]
    if c == "S" {
        var d: [(Int, Int)] = []
        if map[i - 1][j] == "|" || map[i - 1][j] == "F" || map[i - 1][j] == "7" {d.append((-1,0))}
        if map[i + 1][j] == "|" || map[i - 1][j] == "J" || map[i - 1][j] == "L" {d.append((1,0))}

        if map[i][j + 1] == "-" || map[i][j + 1] == "J" || map[i][j + 1] == "7" {d.append((0,1))}
        if map[i][j - 1] == "-" || map[i][j - 1] == "F" || map[i][j - 1] == "L" {d.append((0,-1))}
    return d
    }

    if c == "|" { return [ (-1,0),(1,0) ] }
    if c == "-" { return [ (0,-1),(0,1) ] }
    if c == "F" { return [ (1,0),(0,1) ] }
    if c == "L" { return [ (-1,0),(0,1) ] }
    if c == "7" { return [ (1,0),(0,-1) ] }
    if c == "J" { return [ (-1,0),(0,-1) ] }
    return []
} 

var text = """
......................
..F----7F7F7F7F-7.....
..|F--7||||||||FJ.....
..||.FJ||||||||L7.....
.FJL7L7LJLJ||LJ.L-7...
.L--J.L7...LJS7F-7L7..
.....F-J..F7FJ|L7L7L7.
.....L7.F7||L7|.L7L7|.
......|FJLJ|FJ|F7|.LJ.
.....FJL-7.||.||||....
.....L---J.LJ.LJLJ....
......................
"""

do {
    text = try String(contentsOfFile: "day10.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}

var strs = text.components(separatedBy: "\n")
var map = strs.map { Array($0) }

var si = 0
var sj = 0
var len = 0

(si, sj) = findStart(map)

var v: [String: Bool] = [:]

var list = [(si,sj,0)]

var p: [Int:(Int,Int)] = [:]

while !list.isEmpty {
    let current = list.removeFirst()

    let i = current.0
    let j = current.1
    let l = current.2 

    v["\(i) \(j)"] = true


    if let d = p[l] {
        print(d)
    }
    p[l] = (i,j)

    let moves = charMove(map,i,j)

    if l == 0 {print(moves)}

    if moves.count == 0 { print("XD") }

    for move in moves {
        let ni = i + move.0
        let nj = j + move.1
        if ni >= 0 && ni < map.count && nj >= 0 && nj < map[0].count {
            if l > 2 && map[ni][nj] == "S" { len = l + 1; break }
            if map[ni][nj] != "." && v["\(ni) \(nj)"] == nil { list.append( (ni,nj,l + 1) ) }
        } 
    }

    

    list.sort { $0.2 > $1.2 }
    if len > 0 { break }
}

var ss = [String]()
for i in 0..<map.count {
    var p = ""
    for j in 0..<map[0].count {
        if let _ = v["\(i) \(j)"] {
            p.append("L")
        } else { 
            p.append(".") 
        }
    }
    ss.append(p)
}

var du = ss.map { Array($0) } 

for i in 0..<len {
    if let kl = p[i] {
        du[kl.0][kl.1] = "O"
    }
}

var cnt = 0 

var pp: [(Int,Int)] = [(0,0)]

var vv: [String: Bool] = [:]

let mv = [
    (0,1),
    (0,-1),
    (1,0),
    (-1,0)
]

while !pp.isEmpty {
    let crr = pp.removeFirst()
    let i = crr.0
    let j = crr.1

    if du[i][j] == "K" { continue }

    du[i][j] = "K"

     for move in mv {
        let ni = i + move.0
        let nj = j + move.1
        if ni >= 0 && ni < map.count && nj >= 0 && nj < map[0].count && du[ni][nj] == "." {
            pp.append((ni,nj))
        }
    } 

}

cnt = 0

for i in 0..<du.count {
    for j in 0..<du[i].count {
        if du[i][j] == "." { du[i][j] = "V" }
        if du[i][j] == "O" { du[i][j] = map[i][j] }
    }
}

for i in 0..<du.count {
    for j in 0..<du[i].count { 
        if du[i][j] == "V" { cnt += 1 } 
    }
}

for i in 0..<du.count {
    for j in 0..<du[i].count {

        if du[i][j] == "V" {
            var pcnt = 0 

            for k in 0..<j {
                if du[i][k] == "|" || du[i][k] == "J" || du[i][k] == "L" { pcnt += 1 }   
            }

            if pcnt % 2 == 0 { cnt -= 1 }
        }

    }
}


print(cnt)

