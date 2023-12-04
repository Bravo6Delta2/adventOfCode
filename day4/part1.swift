import Foundation

struct Card {
    let id: Int
    let winning:[Int]
    let my: [Int]

    init (str: String) {
        let strs = str.components(separatedBy: " ")
        self.id = Int("\(strs[1].dropLast())") ?? 0
        var w:[Int] = []
        var m:[Int] = []

        var isM = false

        for s in strs {
            if s == "|" { isM = true } 

            if let n = Int(s) {
                if isM { w.append(n) } else { m.append(n) }
            }
        }

        self.winning = w
        self.my = m
    }

    func numberOfWinings() -> Int {
        var cnt = 0
        for w in winning {
            cnt += my.contains(w) ? 1 : 0
        }
        if cnt == 0 { return 0 }
        return (Int(pow(2.0, Double(cnt - 1)))) 
    }
}

var text = ""
do {
    text = try String(contentsOfFile: "day4.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}

let cards = text.components(separatedBy: "\n").map { Card(str: $0) }

var cnt = 0

for card in cards {
    cnt += card.numberOfWinings()
}

print(cnt)

