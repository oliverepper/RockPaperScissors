//
//  RockPaperScissorsView.swift
//  RockPaperScissors
//
//  Created by Oliver Epper on 22.03.21.
//

import SwiftUI

extension Image {
    func resized(to size: CGFloat) -> some View {
        self
            .resizable()
            .frame(width: size, height: size)
    }
}

struct RockPaperScissorsView: View {
    @StateObject var game = Game()

    var body: some View {
        VStack {
            Text("Rock Paper Scissors").font(.title)
            HStack {
                getImage(for: game.player).resized(to: 75)
                getImage(for: game.opponent).resized(to: 75)
            }
            getLabel(for: game.result)
            HStack {
                getButton(for: .rock)
                getButton(for: .paper)
                getButton(for: .scissors)
            }.buttonStyle(BorderlessButtonStyle())
        }
    }

    func getImage(for handPosition: HandPosition) -> Image {
        switch handPosition {
        case .rock:
            return Image("rock")
        case .paper:
            return Image("paper")
        case .scissors:
            return Image("scissors")
        }
    }

    func getLabel(for result: GameResult) -> Text {
        switch result {
        case .draw:
            return Text("It's a draw")
        case .loose:
            return Text("Better luck next time")
        case .win:
            return Text("You got lucky!")
        }
    }

    func getButton(for handPosition: HandPosition) -> some View {
        return Button(action: {
            game.setPlayer(handPosition)
        }, label: {
            getImage(for: handPosition).resized(to: 35)
        })
    }
}
