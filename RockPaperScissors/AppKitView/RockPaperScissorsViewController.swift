//
//  RockPaperScissorsViewController.swift
//  RockPaperScissors
//
//  Created by Oliver Epper on 22.03.21.
//

import Cocoa
import Combine

class RockPaperScissorsViewController: NSViewController {
    @IBOutlet weak var playerHandPosition: NSImageView!
    @IBOutlet weak var opponentHandPosition: NSImageView!
    @IBOutlet weak var label: NSTextField!

    @objc dynamic var presentSheet = false

    private var game = Game()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        subscribeToPlayer().store(in: &cancellables)
        subscribeToOpponent().store(in: &cancellables)
        subscribeToResult().store(in: &cancellables)
    }

    fileprivate func subscribeToPlayer() -> AnyCancellable {
        return game.$player
            .map(getImage)
            .assign(to: \.image, on: playerHandPosition)
    }

    fileprivate func subscribeToOpponent() -> AnyCancellable {
        return game.$opponent
            .handleEvents(receiveOutput: {
                if self.presentSheet {
                    self.presentAlert(for: $0)
                }
            })
            .map(getImage)
            .assign(to: \.image, on: opponentHandPosition)
    }

    fileprivate func subscribeToResult() -> AnyCancellable {
        return game.$result
            .map(resultText)
            .assign(to: \.stringValue, on: label)
    }

    @IBAction func selection(_ sender: NSButton) {
        let handPosition = HandPosition(rawValue: sender.tag)!
        game.setPlayer(handPosition)
    }

    private func resultText(gameResult: GameResult) -> String {
        switch gameResult {
        case .draw:
            return "It's a draw"
        case .loose:
            return "Better luck next time"
        case .win:
            return "You got lucky!"
        }
    }

    private func getImage(for handPosition: HandPosition) -> NSImage? {
        switch handPosition {
        case .rock:
            return NSImage(named: "rock")
        case .paper:
            return NSImage(named: "paper")
        case .scissors:
            return NSImage(named: "scissors")
        }
    }

    private func presentAlert(for handPosition: HandPosition) {
        guard let window = self.view.window else { return }
        let alert = NSAlert()
        alert.icon = getImage(for: handPosition)
        alert.messageText = "Opponents choice"
        alert.informativeText = "\(handPosition)"
        alert.beginSheetModal(for: window) { _ in }
    }
}
