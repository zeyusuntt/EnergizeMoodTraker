//
//  Entry.swift
//  EnergizeMoodTraker
//
//  Created by 孙泽宇 on 6/7/23.
//

import SwiftUI

struct Entry: View {
    @State var log: Log
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(log.startDate.formatted() + " -- " + log.endDate.formatted())
                .font(.system(size: 10))
            HStack {
                Text(log.emotion.emoji)
                    .font(.system(size: 60))
                VStack(alignment: .leading, spacing: 10) {
                    Text(log.emotion.name)
                        .font(.system(size: 20))
                    HStack {
                        Text(log.tag.emoji)
                        Text(log.tag.name)
                    }
                    Text(log.description)
                }
            }
        }
        
    }
}

struct Entry_Previews: PreviewProvider {
    struct Preview: View {
        @State var log = Log(emotion: Emotion(emoji: "😆", name: "Thrilled"), tag: Tag(emoji: "👨‍👩‍👧‍👦", name: "family", category: "Social"), description: "hiahiahhhhhhhhhhhhhhhhhhhhh", startDate: Date(), endDate: Date())
        var body: some View {
            Entry(log: log)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
