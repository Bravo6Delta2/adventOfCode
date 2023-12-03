import Foundation

var text = ""
do {
    text = try String(contentsOfFile: "day3.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}


var strs = text.components(separatedBy: "\n")
var cnt = 0
var num: [Int] = []


for i in 0..<strs.count {

    let line = strs[i]
    var number = ""
    var isPossible = false


    for j in 0..<line.count {
        let ch = line[line.index(line.startIndex, offsetBy: j)]
        if ch.isNumber {
            number = "\(number)\(ch)"

            if !isPossible {
                var chs: [Character] = []
                

                if j > 0 { chs.append(line[line.index(line.startIndex, offsetBy: j-1)]) }
                if j < line.count - 1 { chs.append(line[line.index(line.startIndex, offsetBy: j+1)]) } 
                

                if i > 0 {
                    let lineup = strs[i-1]
                    chs.append(lineup[lineup.index(lineup.startIndex, offsetBy: j)])
                    if j > 0 { chs.append(lineup[lineup.index(lineup.startIndex, offsetBy: j-1)]) }
                    if j < line.count - 1 { chs.append(lineup[lineup.index(lineup.startIndex, offsetBy: j+1)]) }
                }
                               
                if i < strs.count - 1 {
                    let lineup = strs[i+1]
                    chs.append(lineup[lineup.index(lineup.startIndex, offsetBy: j)])
                    if j > 0 { chs.append(lineup[lineup.index(lineup.startIndex, offsetBy: j-1)]) }
                    if j < line.count - 1 { chs.append(lineup[lineup.index(lineup.startIndex, offsetBy: j+1)]) }
                }

                for cc in chs {
                      if !cc.isNumber && "\(cc)" != "." { isPossible = true }
                }
            }

        } else {
            if number != "" && isPossible { 
                let k = Int(number) ?? 0
                cnt += k
            }
            isPossible = false
            number = ""
        }

    }
     if number != "" && isPossible { 
        let k = Int(number) ?? 0
        cnt += k
    }

}

print(cnt)

