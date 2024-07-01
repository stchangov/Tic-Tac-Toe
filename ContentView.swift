import SwiftUI

struct ContentView: View {
    @ObservedObject var TicTac = TicTacModel()
    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("TicTacToe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                
                Text("TIC TAC TOE")
                    .font(.system(size: 45 , weight: .heavy))
                    .foregroundStyle(.white)
                    .frame(width: 300, height: 50)
                    .padding(20)
                
                if let winner = TicTac.winner {
                    Text("Player \(winner == .X ? "'X'" : "'O'") wins!")
                        .font(.system(size: 32, weight: .heavy))
                        .foregroundStyle(winner == .X ? .lightBlue : .red)
                }
                
                let col = Array(repeating: GridItem(.flexible(), spacing: -10), count: 3)
                
                LazyVGrid(columns: col, content: {
                    ForEach(0..<9) { i in
                        Button(action: {
                            TicTac.buttonTap(i: i)
                        }, label: {
                            TicTac.buttonLabel(i: i)
                                .foregroundStyle(.white)
                                .frame(width: 90, height: 90)
                                .background(.black)
                                .border(.gray)
                                .font(.system(size: 32, weight: .heavy))
                        })
                    }
                })
                .padding(30)
                
                Button(action: {
                    TicTac.resetGame()
                }, label: {
                    Text("Restart")
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundStyle(.white)
                        .frame(width: 130, height: 60)
                        .background(.red)
                })
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}

#Preview {
    ContentView()
}
