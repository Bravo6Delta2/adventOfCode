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

var text = """
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
"""

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

var dict:[UInt64 : Bool] = [:]

var minSeed = UInt64.max

for i in stride(from: 0, to: seeds.count, by: 2) {
    for j in stride( from: 0 ,to: seeds[i+1], by: 1000) {
        var source = UInt64(seeds[i]) + j
       if let _ = dict[source] { continue }
       dict[source] = true

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
    

        if source < minDes { minDes = source; minSeed = UInt64(seeds[i]) + j}
    }
}


for seed:UInt64 in 1...10000 {
    var source = minSeed - seed
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
