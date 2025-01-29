//
//  main.swift
//  BerlinClock
//
//  Created by あせむ on 28.01.2025.
//

import Foundation

enum LampColor: String {
    case off = "O"
    case red = "R"
    case yellow = "Y"
}

struct BerlinClock {
    let hours: Int
    let minutes: Int
    let seconds: Int

    var secondsRow: String {
        return seconds % 2 == 0 ? LampColor.yellow.rawValue : LampColor.off.rawValue
    }

    var fiveHourRow: String {
        return buildRow(activeLamps: hours / 5, totalLamps: 4, color: .red)
    }

    var oneHourRow: String {
        return buildRow(activeLamps: hours % 5, totalLamps: 4, color: .red)
    }

    var fiveMinuteRow: String {
        var row = ""
        for i in 1...11 {
            if i <= minutes / 5 {
                // Every third lamp is red
                row += (i % 3 == 0) ? LampColor.red.rawValue : LampColor.yellow.rawValue
            } else {
                row += LampColor.off.rawValue
            }
        }
        return row
    }

    var oneMinuteRow: String {
        return buildRow(activeLamps: minutes % 5, totalLamps: 4, color: .yellow)
    }

    private func buildRow(activeLamps: Int, totalLamps: Int, color: LampColor) -> String {
        var row = ""
        for i in 0..<totalLamps {
            row += (i < activeLamps) ? color.rawValue : LampColor.off.rawValue
        }
        return row
    }

    func display() -> String {
        return """
        \(secondsRow)
        \(fiveHourRow)
        \(oneHourRow)
        \(fiveMinuteRow)
        \(oneMinuteRow)
        """
    }
}

func berlinClock(for time: String) {
    let components = time.split(separator: ":").compactMap { Int($0) }
    guard components.count == 3 else {
        print("Invalid time format. Use HH:mm:ss")
        return
    }

    let clock = BerlinClock(hours: components[0], minutes: components[1], seconds: components[2])
    print(clock.display())
}
