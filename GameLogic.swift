import Foundation
import SwiftUI

enum Player {
    case X
    case O
}

class TicTacModel: ObservableObject {
    @Published var board: [Player?] = Array(repeating: nil, count: 9)
    @Published var activePlayer: Player = .X
    @Published var winner: Player? = nil
    
    // Button presed
    func buttonTap(i: Int) {  // if button has not been tapped
        guard board[i] == nil && winner == nil else {
            return
        }
        
        board[i] = activePlayer
        
        if checkWinner() {  // If we have a winner
            winner = activePlayer
            print("\(activePlayer) has won the game!")
        } else {
            activePlayer = (activePlayer == .X) ? .O : .X
        }
    }
    
    // Label of Button
    func buttonLabel(i: Int) -> Text {
        if let player = board[i] {
            return player == .X ? Text("X").foregroundStyle(Color("lightBlue")) : Text("O").foregroundStyle(.red)
        }
        return Text("")
    }
    
    // Reset Game
    func resetGame() {
        board = Array(repeating: nil, count: 9)
        activePlayer = .X
        winner = nil
    }
    
    // Check for winner
    func checkWinner() -> Bool {
        // Check the rows
        for i in stride(from: 0, to: 9, by: 3) {
            if board[i] == activePlayer && board[i + 1] == activePlayer && board[i + 2] == activePlayer {
                return true
            }
        }
        // Check the columns
        for i in 0..<3 {
            if board[i] == activePlayer && board[i + 3] == activePlayer && board[i + 6] == activePlayer {
                return true
            }
        }
        
        // Check diaganolly
        if board[0] == activePlayer && board[4] == activePlayer && board[8] == activePlayer {  // Left to right diagonal
            return true
        } else if board[2] == activePlayer && board[4] == activePlayer && board[6] == activePlayer {  // Right to left diagonal
            return true
        }
        
        return false
    }
}
