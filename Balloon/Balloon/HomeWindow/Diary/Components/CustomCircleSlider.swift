//
//  CustomCircleSlider.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 16.12.2023.
//

import SwiftUI
// Кастомный слайдер для ввода показателей, путем прокручивания по кругу
struct CustomCircleSlider :View {
    private var widthCircle:CGFloat = 40
    @State var size: CGFloat = UIScreen.main.bounds.width - 150
    @State var progress:CGFloat = 0
    @State var angle:Double = 0
    @Binding var count:Double
    @State var measurement:String
    @State var koef:Double
    @State var format:String = "%.1f"
    @Binding var needRefresh:Bool
    @State var lowLevel: Double
    @State var highLevel: Double
    @State var color: Color
    
    init(count: Binding<Double>, measurement: String, koef: Double, format:String = "%.1f", needRefresh:Binding<Bool>, lowLevel: Double = 0, highLevel: Double = 300) {
        self.measurement = measurement
        self.koef = koef
        self.format = format
        self._count = count
        self._needRefresh = needRefresh
        self.lowLevel = lowLevel
        self.highLevel = highLevel == 300 ? koef : highLevel
        self.color = (count.wrappedValue < lowLevel || count.wrappedValue > (highLevel == 300 ? koef : highLevel)) ? Color.red : Color("BaseColor")
    }
    
    var body: some View {
        ZStack {
            Circle().stroke(.gray, style: StrokeStyle(lineWidth: widthCircle, lineCap: .round, lineJoin: .round)).frame(width: size, height: size).rotationEffect(.init(degrees: -90))
            
            // progress
            Circle()
                .trim(from: 0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: widthCircle, lineCap: .butt, lineJoin: .round))
                .frame(width: size, height: size).rotationEffect(.init(degrees: -90))
            Circle()
                .fill(.gray)
                .frame(width: widthCircle, height: widthCircle)
                .offset(x: size / 2)
                .rotationEffect(.init(degrees: -90))
            
            Circle().fill(Color.white).frame(width: widthCircle, height: widthCircle).offset(x: size / 2)
                .rotationEffect(.init(degrees: angle))
                .gesture(DragGesture().onChanged(onDrag(value:)))
                .rotationEffect(.init(degrees: -90))
            Text(String(format: format, progress * koef) + " " + measurement)
                .font(.title)
                .fontWeight(.medium)
        }.accentColor(needRefresh ? .white : .black)
            .onAppear {
                         progress = count / koef
                         angle = progress * 360
                     }
        .onChange(of: count, perform: { value in
           
            color = (value < lowLevel || value > highLevel) ? Color.red : Color("BaseColor")
            })
    }
    
    func onDrag(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - widthCircle/2, vector.dx - widthCircle/2)
        // converting to angle...
        var angle = radians * 180 / .pi
        if (angle < 0) {
            angle = 360 + angle
        }
        withAnimation(Animation.linear(duration: 0.15)) {
            let progress = angle / 360
            self.progress = progress
            self.angle = Double(angle)
            self.count = progress * koef
        }
    }
}
