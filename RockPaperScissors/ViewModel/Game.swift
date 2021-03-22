//
//  Game.swift
//  RockPaperScissors
//
//  Created by Oliver Epper on 22.03.21.
//

import Foundation

class Game: ObservableObject {
    @Published private(set) var player: HandPosition = .rock
    @Published private(set) var opponent: HandPosition = .rock
    @Published var result: GameResult = .draw

    private var opponentPlayedByComputer = true

    init() {
        $player.zip($opponent)
            .map(score)
            .assign(to: &$result)
    }

    func setPlayer(_ hand: HandPosition) {
        player = hand
        if opponentPlayedByComputer {
            let randomPosition = HandPosition(rawValue: Int.random(in: 0..<3))!
            setOpponent(randomPosition)
        }

    }

    func setOpponent(_ hand: HandPosition) {
        opponent = hand
    }
}
