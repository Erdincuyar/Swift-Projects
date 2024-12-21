//
//  StolenJokeView.swift
//  Meriz
//
//  Created by Erdinç Uyar on 16.05.2025.
//

import SwiftUI

struct StolenJokeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isRed = true
    @State private var timerCount = 0

    let displayTime: Int = 3 // saniye

    var body: some View {
        ZStack {
            Color.red
                .opacity(isRed ? 1 : 0.3)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isRed)

            VStack(spacing: 20) {
                Image("stolenImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.9) // biraz transparan görünüm

                Text("ÇALINTI ŞAKA")
                    .font(.system(size: 48, weight: .heavy))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.8), radius: 10, x: 0, y: 4)
            }
            .transition(.opacity)

        }
        .onAppear {
            isRed.toggle()
            startTimer()
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: Double(displayTime), repeats: false) { _ in
            dismiss() // Ana ekrana geri dön
        }
    }
}
