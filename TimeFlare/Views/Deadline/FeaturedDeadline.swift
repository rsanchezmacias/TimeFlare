//
//  FeaturedDeadline.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/31/23.
//

import SwiftUI

struct FeaturedDeadline: View {
    
    var deadline: Deadline
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.9), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .top
        )
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            if deadline.image != nil {
                deadline.image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.3)
                    .frame(height: 200)
                    .clipped()
                    .overlay(content: {
                        ZStack {
                            gradient
                            HStack(spacing: 24, content: {
                                VStack(alignment: .leading, spacing: 4, content: {
                                    Text(deadline.title)
                                        .font(.headline)
                                        .lineLimit(0)
                                    Text(deadline.endDate, format: .dateTime)
                                        .font(.subheadline)
                                    if let body = deadline.body {
                                        Text(body)
                                            .font(.caption)
                                            .lineLimit(2)
                                            .padding(.top, 4)
                                    }
                                })
                                .padding(.leading, 16)
                                
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 2)
                                    .padding([.top, .bottom])
                                CountdownDateTimer(endDate: deadline.endDate)
                                    .font(.system(size: 14))
                                    .frame(width: min(geometry.size.width * 0.40, 80))
                                    .padding(.trailing, 16)
                            })
                            .bold()
                            .frame(width: geometry.size.width)
                            .foregroundStyle(Color.white)
                            .background(Color.black.opacity(0.3))
                        }
                    })
            } else {
                Color.mikadoYellow
                    .opacity(0.7)
                    .frame(height: 200)
                    .clipped()
                    .overlay(content: {
                        ZStack {
                            gradient
                        }
                    })
                    .overlay(content: {
                        ZStack {
                            gradient
                            HStack(spacing: 24, content: {
                                VStack(alignment: .leading, spacing: 4, content: {
                                    Text(deadline.title)
                                        .font(.headline)
                                        .lineLimit(0)
                                    Text(deadline.endDate, format: .dateTime)
                                        .font(.subheadline)
                                    if let body = deadline.body {
                                        Text(body)
                                            .font(.caption)
                                            .lineLimit(2)
                                            .padding(.top, 4)
                                    }
                                })
                                .padding(.leading, 16)
                                
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 2)
                                    .padding([.top, .bottom])
                                CountdownDateTimer(endDate: deadline.endDate)
                                    .font(.system(size: 14))
                                    .frame(width: min(geometry.size.width * 0.40, 80))
                                    .padding(.trailing, 16)
                            })
                            .bold()
                            .frame(width: geometry.size.width)
                            .foregroundStyle(Color.white)
                            .background(Color.black.opacity(0.3))
                        }
                    })
            }
        })
    }
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    let manager = DeadlineManager(container: container)
    return FeaturedDeadline(deadline: SampleDeadline.sampleDeadlines[0])
        .environmentObject(manager)
        .frame(height: 150)
}
