//
//  ContentView.swift
//  snoozeme WatchKit Extension
//
//  Created by Keith Baker on 28/04/2021.
//

import SwiftUI

let numberOfSamples: Int = 10

struct ContentView: View {
    
    // 1
    @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)
    
    // 2
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (200 / 25)) // scaled to max at 200 (our height of our bar)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Label("Snooze Me", systemImage: "bed.double.fill")
            Spacer()
             // 3
            HStack(spacing: 4) {
                 // 4
                ForEach(mic.soundSamples, id: \.self) { level in
                    BarView(value: self.normalizeSoundLevel(level: level))
                }
            }
            Spacer()
        }
    }
}

struct BarView: View {
   // 1
    var value: CGFloat

    var body: some View {
        ZStack {
           // 2
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                // 3
                .frame(minWidth: (0 - CGFloat(numberOfSamples) * 2) / CGFloat(numberOfSamples), maxHeight: value)
        }
    }
}
