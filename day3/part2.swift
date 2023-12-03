import Foundation

var text = ""
do {
    text = try String(contentsOfFile: "day3.txt")
} catch {
    print("Error reading contents: \(error.localizedDescription)")
}


var strs = text.components(separatedBy: "\n")
var cnt:UInt = 0
var ts: [[String]] = []

for i in 0..<strs.count {
    ts.append([])

    let line = strs[i]
    var num = ""

    for j in 0..<line.count {

        let ch = line[line.index(line.startIndex, offsetBy: j)]

        ts[i].append("\(ch)")

        if ch.isNumber {
            num = "\(num)\(ch)"
        } else {
            if num != "" {
                for k in 0..<num.count {
                    ts[i][j-k-1] = num
                }
                num = ""
            }
        }  
    }

    if num != "" {
        for k in 0..<num.count {
            ts[i][line.count-1-k] = num
        }
    }
} 


for i in 0..<ts.count {
    for j in 0..<ts[i].count {
        if ts[i][j] == "*" {
 
            var a: UInt? = nil
            var b: UInt? = nil

            var kk:[[UInt?]] = [[],[nil,nil,nil],[]]

            if j > 0 { 
                a = UInt(ts[i][j-1])
                kk[1][0] = UInt(ts[i][j-1]) 
            }

            if j < ts[i].count - 1 { 
                kk[1][2] = UInt(ts[i][j+1])
                if a == nil { a = UInt(ts[i][j+1])} else if b == nil { b = UInt(ts[i][j+1]) } 
            }


            if i > 0 { 
                var p: [UInt?] = [nil,nil,nil]

                if j > 0 { p[0] = UInt(ts[i-1][j-1]) }
                p[1] = UInt(ts[i-1][j])  
                if j < ts[i-1].count - 1 { p[2] = UInt(ts[i-1][j+1]) } 

                kk[0] = p

                if (a != nil && b != nil) {  
                    if p[0] != nil || p[1] != nil || p[2] != nil { a = 0 }
                }

                if (a != nil && b == nil) {
                    if p[0] != nil && p[1] == nil && p[2] != nil { a = 0 }
                }

                if a == nil && b == nil {
                    if p[0] != nil && p[1] == nil && p[2] != nil {
                        a = p[0]
                        b = p[2]
                    }
                } 

                if a == nil {
                   if p[0] != nil { a = p[0] }
                   if p[1] != nil { a = p[1] } 
                   if p[2] != nil { a = p[2] }  
                } else {
                    if b == nil {
                        if p[0] != nil { b = p[0] }
                        if p[1] != nil { b = p[1] } 
                        if p[2] != nil { b = p[2] }  
                    }
                }
  
            }

             if i < ts.count - 1 { 
                var p: [UInt?] = [nil,nil,nil]

                if j > 0 { p[0] = UInt(ts[i+1][j-1]) }
                p[1] = UInt(ts[i+1][j])  
                if j < ts[i+1].count - 1 { p[2] = UInt(ts[i+1][j+1]) } 

                kk[2] = p

                if (a != nil && b != nil) {  
                    if p[0] != nil || p[1] != nil || p[2] != nil { a = 0 }
                }

                if (a != nil && b == nil) {
                    if p[0] != nil && p[1] == nil && p[2] != nil { a = 0 }
                }

                if a == nil && b == nil {
                    if p[0] != nil && p[1] == nil && p[2] != nil {
                        a = p[0]
                        b = p[2]
                    }
                }

                if b == nil {
                   if p[0] != nil { b = p[0] }
                   if p[1] != nil { b = p[1] } 
                   if p[2] != nil { b = p[2] }  
                }

            }
           
            let a1 = a ?? 0
            let b1 = b ?? 0


            cnt += a1*b1   
        }
    }
}

print(cnt)



