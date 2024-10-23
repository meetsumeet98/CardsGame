//
//  ContentView.swift
//  CardsGame
//
    //  Created by Sumeet Bhujang on 10/09/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🎃", "😈", "👻", "🕷", "🍏", "🍌", "🥝", "🥋", "🐹", "🐔", "🐤", "🐣", "🦉", "🦄", "🦂", "🐢", "🐍", "🦕", "🦀"]

    @State var cardCount = 4
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()

        /*
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.orange)
            Text("Hello, world!")
                .padding()
        }

        VStack(content: {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.orange)
            Text("Hello, world!")
                .padding()
        })

        VStack(){
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.orange)
            Text("Hello, world!")
                .padding()
        }
         */
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0 ..< cardCount , id: \.self) { index in // ViewBuilder closure
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }

    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: { // ** this is a viewBuilder closure **
            Image(systemName: symbol)
        }).disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }

    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }

    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View {
    let content: String
    @State var isFlipped = false

    var body: some View {
//        ZStack() {
//            let base = RoundedRectangle(cornerRadius: 12)
//            if isFlipped {
//                base.foregroundColor(.white)
//                base.strokeBorder(lineWidth: 2)
//                Text("👻")
//            } else {
//                base.fill()
//            }
//        }.onTapGesture {
//            isFlipped = !isFlipped
//        }

        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).padding()
            }.opacity(isFlipped ? 1 : 0)

            base.fill().opacity(isFlipped ? 0 : 1)
        }.onTapGesture {
            isFlipped = !isFlipped
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
