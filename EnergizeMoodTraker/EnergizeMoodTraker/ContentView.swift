//
//  ContentView.swift
//  EnergizeMoodTraker
//
//  Created by 孙泽宇 on 6/6/23.
//

import SwiftUI

//struct ContentView: View {
//    @State private var logList = LogList(named: "test")
//    var body: some View {
//        TabView {
//            LogListView(logList: logList)
//                .tabItem {
//                    Image(systemName: "book.fill")
//                    Text("Entries")
//                }
//            LogEditor()
//                .tabItem {
//                    Image(systemName: "pencil.circle.fill")
//                    Text("Log")
//                }
//        }
//        .font(.headline)
//    }
//}

enum Tab {
    case first
    case second
}



struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

struct ContentView: View {
    @State private var logList = LogList(named: "test")
    @State private var selectedTab: Tab = .first
    @State private var showNewAddedLog = false
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .first:
                NavigationView {
                    LogListView(logList: logList)
                }
            case .second:
                NavigationView {
                    AnalysisView()
                }
            }
            
            
            CustomTabView(selectedTab: $selectedTab, showNewAddedLog: $showNewAddedLog, logList: $logList)
                .frame(height: 50)
        }
        .sheet(isPresented: $showNewAddedLog) {
            LogEditor(log: $logList.logs[0])
                .environmentObject(TagList(named: logList.name))
        }
    }
}

struct CustomTabView: View {
    @Binding var selectedTab: Tab
    @Binding var showNewAddedLog: Bool
    @Binding var logList :LogList
    var body: some View {
        HStack {
            Spacer()
            Button {
                selectedTab = .first
            } label: {
                VStack {
                    Image(systemName: "list.bullet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("Logs")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .first ? .blue : .primary)
            }
            
            Spacer()
            
            Button {
                logList.insert(emotion: Emotion(emoji: "", name: ""), tag: Tag(emoji: "", name: "", category: ""), description: "", startDate: Date(), endDate: Date(), at:0)
                showNewAddedLog = true
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .shadow(radius: 2)
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.primary)
                        .frame(width: 72, height: 72)
                }
                .offset(y: -32)
            }
            .buttonStyle(TabButtonStyle())
            
            Spacer()
            
            Button {
                selectedTab = .second
            } label: {
                VStack {
                    Image(systemName: "chart.pie")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("Analysis")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .second ? .blue : .primary)
            }
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
