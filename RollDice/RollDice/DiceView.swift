//
//  DiceView.swift
//  RollDice
//
//  Created by Francisco Ruiz on 26/01/22.
//

import SwiftUI

struct DiceView: View {
    let dice: Dice
    
    var body: some View {
        VStack {
            /*
            Circle()
                .fill(.gray)
                .frame(width: 10, height: 10)
            */
            Text("\(dice.number)")
                .font(.title)
                .foregroundColor(.gray)
        }
        .frame(width: 50, height: 50)
        .background(.white)
        .cornerRadius(5)
        .padding(3)
        .background(.gray)
        .cornerRadius(5)
    }
}
/*
struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
*/
