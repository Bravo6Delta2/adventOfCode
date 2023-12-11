import Foundation

func findStart(_ map: [[String.Element]]) -> (Int, Int) {
    for i in 0..<map.count {
        for j in 0..<map[i].count {
            if map[i][j] == "S" { return (i,j) }
        }
    }
    return (0,0)
}

func charMove (_ c: String.Element) -> [(Int,Int)] {
    if c == "S" { return [ (-1,0),(1,0),(0,-1),(0,1) ] }
    if c == "|" { return [ (-1,0),(1,0) ] }
    if c == "-" { return [ (0,-1),(0,1) ] }
    if c == "F" { return [ (1,0),(0,1) ] }
    if c == "L" { return [ (-1,0),(0,1) ] }
    if c == "7" { return [ (1,0),(0,-1) ] }
    if c == "J" { return [ (-1,0),(0,-1) ] }
    return []
} 

var text = """
.....
.S-7.
.|.|.
.L-J.
.....
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

while !list.isEmpty {
    let current = list.removeFirst()

    let i = current.0
    let j = current.1
    let l = current.2 

    v["\(i) \(j)"] = true

    let moves = charMove(map[i][j])

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


print(len / 2)


