//
//  ContentView.swift
//  TimerAnimation
//
//  Created by Antoine Lucchini on 24/03/2023.
//

import SwiftUI

struct ContentView: View {

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var advancment = 0.0
    @State var countdown = 10
    private var size = 300.0

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(.pink.opacity(0.2))
                Arc(endAngle: advancment)
                .stroke(.pink, lineWidth: size / 2)
                .frame(width: size / 2, height: size / 2)
                .onReceive(timer) { _ in
                    if advancment < 360 {
                        withAnimation(Animation.easeInOut) {
                            advancment += 36
                        }
                        countdown -= 1
                    }
                }
                Text(String(countdown))
                    .foregroundColor(.white)
                    .font(.system(size: 150))
            }
            Spacer()
                .frame(height: 140)
            Button("Reset", action: {
                advancment = 0
                countdown = 10
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Arc: Shape {
    var startAngle: Angle = .degrees(0)
    var endAngle: Double
    var clockwise: Bool = true

    var animatableData: Double {
        get { endAngle }
        set { endAngle = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = .degrees(endAngle) - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}
