import Foundation

struct RGB {
    let red: Int
    let green: Int
    let blue: Int
}

struct Game {
    let id: Int
    let pulls: [RGB]

    init (line: String) {

        let p = "\(line.dropFirst(5))"

        let strs = p.components(separatedBy: ":")

        self.id = Int(strs[0]) ?? 0
        
        var r = 0
        var g = 0
        var b = 0
        var pulls1: [RGB] = []


        for str in strs[1].components(separatedBy: ";") {
            for pp in str.components(separatedBy: ",") {
                let bb = pp.components(separatedBy: " ")
                let num = Int(bb[1]) ?? 0
                if bb[2].contains("red") {
                    r = num
                }
                if bb[2].contains("green") {
                    g = num
                } 
                 if bb[2].contains("blue") {
                    b = num
                }    
            }

            pulls1.append(RGB(red: r, green: g, blue: b))
            r = 0
            g = 0
            b = 0
        }
        self.pulls = pulls1
    }
}


var text = ""
do {
    text = try String(contentsOfFile: "day2.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}

let lines = text.components(separatedBy: "\n")
let games = lines.map { Game(line: $0) }
var cnt = 0
for game in games {
    var r = game.pulls[0].red
    var g = game.pulls[0].green
    var b = game.pulls[0].blue
    for rgb in game.pulls {
        if r < rgb.red { r = rgb.red }
        if g < rgb.green { g = rgb.green }
        if b < rgb.blue { b = rgb.blue }
    }
    cnt += (r * g * b)
}

print(cnt)
