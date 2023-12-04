import Foundation

struct Card {
    let id: Int
    let winning:[Int]
    let my: [Int]
    var repetions: Int = 1
    let numberOfWinings: Int

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
        var cnt = 0
        for w in winning {
            cnt += my.contains(w) ? 1 : 0
        }
        self.numberOfWinings = cnt
    }

 
}

var text = ""
do {
    text = try String(contentsOfFile: "day4.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}

var cards = text.components(separatedBy: "\n").map { Card(str: $0) }

func rr (i: Int) {
    let p = cards[i].numberOfWinings
    if p == 0 { return }
    for j in 1...p {
        if i + j < cards.count {
            cards[i + j].repetions += 1
            rr(i: i + j)
        }
    }
}

for i in 0..<cards.count {
    rr(i: i)
}

var cnt = 0

for card in cards {
    cnt += card.repetions
}

print(cnt)

