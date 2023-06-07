//
//  LogListView.swift
//  EnergizeMoodTraker
//
//  Created by 孙泽宇 on 6/6/23.
//

import SwiftUI

struct LogListView: View {
    @ObservedObject var logList: LogList
    
    @State private var showCursorPalette = false

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(logList.logs) { log in
                    NavigationLink(value: log.id) {
//                        Text(log.emotion.name)
//                        Entry(log: log)
                        // why entry not working
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
                .onDelete { indexSet in
                    withAnimation {
                        logList.logs.remove(atOffsets: indexSet)
                    }
                }
                .onMove { indexSet, newOffset in
                    logList.logs.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationDestination(for: Log.ID.self) { logId in
                if let index = logList.logs.firstIndex(where: { $0.id == logId }) {
                    LogEditor(log: $logList.logs[index])
                        .environmentObject(TagList(named: logList.name))
                }
            }
            .navigationDestination(isPresented: $showCursorPalette) {
                LogEditor(log: $logList.logs[0])
                    .environmentObject(TagList(named: logList.name))
            }
            .navigationTitle("Log your mood!")
            .toolbar {
                ToolbarItem {
                    Button {
                        logList.insert(emotion: Emotion(emoji: "", name: ""), tag: Tag(emoji: "", name: "", category: ""), description: "", startDate: Date(), endDate: Date(), at:0)
                        showCursorPalette = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}



struct LogListView_Previews: PreviewProvider {
    struct Preview: View {
        @State private var logList = LogList(named: "test")
        var body: some View {
            LogListView(logList: logList)
        }
    }
    static var previews: some View {
        Preview()
    }
}
