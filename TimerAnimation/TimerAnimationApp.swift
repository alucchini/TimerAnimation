//
//  TimerAnimationApp.swift
//  TimerAnimation
//
//  Created by Antoine Lucchini on 24/03/2023.
//

import SwiftUI

@main
struct TimerAnimationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var advancment: Double = 0.0
    @State private var countdown: Int = 10
    @State private var size: Double = 300.0

    var body: some View {
        TimerView(advancment: $advancment, countdown: $countdown, size: $size)
        .onReceive(timer) { _ in
            if advancment < 360 {
                withAnimation(Animation.easeInOut) {
                    advancment += 36
                }
                countdown -= 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
