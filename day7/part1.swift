import Foundation

class BinaryTreeNode {
    var value: Hand
    var leftChild: BinaryTreeNode?
    var rightChild: BinaryTreeNode?

    init(_ value: Hand) {
        self.value = value
    }

    func insert(_ value: Hand) {
        if value < self.value {
            if let left = leftChild {
                left.insert(value)
            } else {
                leftChild = BinaryTreeNode(value)
            }
        } else {
            if let right = rightChild {
                right.insert(value)
            } else {
                rightChild = BinaryTreeNode(value)
            }
        }
    }

    func inorderTraversal() -> [Hand] {
        var result: [Hand] = []
        result += leftChild?.inorderTraversal() ?? []
        result.append(value)
        result += rightChild?.inorderTraversal() ?? []
        return result
    }
}


struct Hand: Comparable {
    let hand: String
    let mul: Int

    init(str: String) {
        let f = str.components(separatedBy: " ")
        var text = f[0]
        text = text.replacingOccurrences(of: "2", with: "A")
        text = text.replacingOccurrences(of: "3", with: "B")
        text = text.replacingOccurrences(of: "4", with: "C")
        text = text.replacingOccurrences(of: "5", with: "D")
        text = text.replacingOccurrences(of: "6", with: "E")
        text = text.replacingOccurrences(of: "7", with: "F")
        text = text.replacingOccurrences(of: "8", with: "G")
        text = text.replacingOccurrences(of: "9", with: "H")
        hand = text

        mul = Int(f[1]) ?? 0
    }

    func getStregnht() -> Int {
        let d = hand.sorted()
        if d[0] == d[4] { return 7 }
        if d[0] == d[3] || d[1] == d[4] { return 6 }
        if (d[0] == d[2] && d[3] == d[4]) || (d[0] == d[1] && d[2] == d[4]) { return 5 }
        if (d[0] == d[2]) || (d[1] == d[3]) || (d[2] == d[4]) { return 4 }
        if (d[0] == d[1] && d[2] == d[3]) || (d[0] == d[1] && d[3] == d[4]) || (d[1] == d[2] && d[3] == d[4]) { return 3 }
        if (d[0] == d[1]) || (d[1] == d[2]) || (d[2] == d[3]) || (d[3] == d[4] ) { return 2 }
        return 1
    }

    static func > (lhs: Hand, rhs: Hand) -> Bool {
        let l = lhs.getStregnht()
        let r = rhs.getStregnht()

        if l > r { return true }
        if l < r { return false }

        let l1 = Array(lhs.hand)
        let r1 = Array(rhs.hand) 

        if l1[0] > r1[0] { return true }
        if l1[0] < r1[0] { return false }  

        if l1[1] > r1[1] { return true }
        if l1[1] < r1[1] { return false } 

        if l1[2] > r1[2] { return true }
        if l1[2] < r1[2] { return false }  


        if l1[3] > r1[3] { return true }
        if l1[3] < r1[3] { return false }  

        if l1[4] > r1[4] { return true }
        if l1[4] < r1[4] { return false }  

        if l1[5] > r1[5] { return true }
        if l1[5] < r1[5] { return false }    

        return true
    }

    static func < (lhs: Hand, rhs: Hand) -> Bool {
        let d = lhs > rhs
        return !d
    }
} 

var text = """
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
"""

do {
    text = try String(contentsOfFile: "day7.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}

text = text.replacingOccurrences(of: "A", with: "e")
text = text.replacingOccurrences(of: "K", with: "d")
text = text.replacingOccurrences(of: "Q", with: "c")
text = text.replacingOccurrences(of: "J", with: "b")
text = text.replacingOccurrences(of: "T", with: "a")

let hands = text.components(separatedBy: "\n").map { Hand(str: $0) }

let rootNode = BinaryTreeNode(hands[0])

for i in 1..<hands.count {
    rootNode.insert(hands[i])
}
let dd = rootNode.inorderTraversal()

var cnt: Int = 0 
for i: Int in 0..<dd.count {
    cnt += dd[i].mul * (i + 1)
}

print(cnt)


