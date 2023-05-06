//
//  ContentView.swift
//  TimerAnimation
//
//  Created by Antoine Lucchini on 24/03/2023.
//

import SwiftUI

struct TimerView: View {

    @Binding var advancment: Double
    @Binding var countdown: Int
    @Binding var size: Double

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(.pink.opacity(0.2))
                Arc(endAngle: advancment)
                .stroke(.pink, lineWidth: size / 2)
                .frame(width: size / 2, height: size / 2)
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
