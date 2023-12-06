import Foundation

struct DSL {
    let destination: UInt64
    let source: UInt64
    let length: UInt64

    func findDestFrom(src: UInt64) -> UInt64 {
        if src >= source && src < source + length {
            return destination + (src - source)
        } 
        return src
    }
}

struct Map {
    let name: String
    var dsls: [DSL] = []
}

var text = ""

do {
    text = try String(contentsOfFile: "day5.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}

let strs = text.components(separatedBy:"\n")

let seeds = strs[0].components(separatedBy:" ").dropFirst().map { UInt64($0) ?? 0 }

var maps: [Map] = []

for i in  2..<strs.count {
    if strs[i] == "" { continue }
    if strs[i].contains("map") { 
        maps.append( Map(name: strs[i].components(separatedBy: " ")[0]) )
        continue
    }

    let nums = strs[i].components(separatedBy: " ")

    let dsl = DSL(
        destination: UInt64(nums[0]) ?? 0, 
        source: UInt64(nums[1]) ?? 0, 
        length: UInt64(nums[2]) ?? 0
    )

    maps[maps.count - 1].dsls.append(dsl)
}

var minDes: UInt64 = UInt64.max

for seed in seeds {
    var source = seed
    for map in maps {
        var des = source

        for dsl in map.dsls {
            let newDest = dsl.findDestFrom(src: des)
            if newDest != des {
                des = newDest
                break
            }
        }

        source = des
    }

    if source < minDes { minDes = source }
} 

print(minDes)
