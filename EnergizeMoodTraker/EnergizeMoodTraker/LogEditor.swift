//
//  LogEditor.swift
//  EnergizeMoodTraker
//
//  Created by 孙泽宇 on 6/7/23.
//

import SwiftUI

struct LogEditor: View {
    @Binding var log: Log
    
    @EnvironmentObject var tagList: TagList
    
    let rows = [
            GridItem(.fixed(50)),
        ]
    
    let columns = [
            GridItem(.fixed(50)),
            GridItem(.fixed(50)),
            GridItem(.fixed(50)),
            GridItem(.fixed(50)),
            GridItem(.fixed(50)),
            GridItem(.fixed(50))
        ]
    
    var body: some View {
        Form {
            Section(header: Text("Emotion")) {
                LazyHGrid(rows: rows) {
                    ForEach(Emotion.emotionList) { emotion in
                        VStack {
                            Text(emotion.emoji)
                                .font(.system(size: 45))
                                .scaleEffect(log.emotion.name == emotion.name ? 1.1 : 1.0) // Scale up the selected emoji
                            
                            Text(emotion.name)
                                .font(.system(size: 8))
                        }
                        .opacity(emotion.name == log.emotion.name ? 0.5: 1)
                        .onTapGesture {
                            withAnimation {
                                log.emotion = Emotion(emoji: emotion.emoji, name: emotion.name)
                            }
                        }
                    }
                }
            }
            
            Section(header: Text("Tags")) {
                LazyVGrid(columns: columns) {
                    ForEach(tagList.tags) { tag in
                        VStack {
                            Text(tag.emoji)
                                .font(.system(size: 45))
                                .scaleEffect(log.tag.name == tag.name ? 1.1 : 1.0) // Scale up the selected emoji
                            
                            Text(tag.name)
                                .font(.system(size: 8))
                        }
                        .opacity(log.tag.name == tag.name ? 0.5: 1)
                        .onTapGesture {
                            withAnimation {
                                log.tag = Tag(emoji: tag.emoji, name: tag.name, category: tag.category)
                                                }
                        }
                    }
                }
            }
            Section(header: Text("Start Time")) {
                DatePicker("", selection: $log.startDate, displayedComponents: [.date, .hourAndMinute])
                            .labelsHidden()
                
            }
            Section(header: Text("End Time")) {
                DatePicker("", selection: $log.endDate, displayedComponents: [.date, .hourAndMinute])
                            .labelsHidden()
                
            }
            Section(header: Text("Description")) {
                TextField("Add Description", text: $log.description)
            }
        }
    }
}


struct LogEditor_Previews: PreviewProvider {
    struct Preview: View {
        @State private var log = Log(emotion: Emotion(emoji: "☹️", name: "Bad"), tag: Tag(emoji: "🍷", name: "date", category: "Social"), description: "nothing", startDate: Date(), endDate: Date())
        var body: some View {
            LogEditor(log: $log)
        }
        
    }
    static var previews: some View {
        
        Preview()
    }
}





