//
//  Model.swift
//  RockPaperScissors
//
//  Created by Oliver Epper on 22.03.21.
//

import Foundation

enum HandPosition: Int {
    case rock
    case paper
    case scissors

    func isDirectSuccessor(of other: HandPosition) -> Bool {
        return self.rawValue == (other.rawValue + 1) % 3
    }
}

enum GameResult {
    case draw
    case win
    case loose
}

func score(player: HandPosition, opponent: HandPosition) -> GameResult {
    if player == opponent { return .draw }
    if player.isDirectSuccessor(of: opponent) { return .win}
    return .loose
}
