//
//  LogList.swift
//  EnergizeMoodTraker
//
//  Created by 孙泽宇 on 6/6/23.
//

import Foundation

extension UserDefaults {
    func logs(forKey key: String) -> [Log] {
        if let jsonData = data(forKey: key),
           let decodedlogs = try? JSONDecoder().decode([Log].self, from: jsonData) {
            return decodedlogs
        } else {
            return []
        }
    }
    func set(_ logs: [Log], forKey key: String) {
        let data = try? JSONEncoder().encode(logs)
        set(data, forKey: key)
    }
}

class LogList: ObservableObject, Identifiable {
    let name: String
    
    var id: String { name }
    
    
    
    private var userDefaultKey: String { "Logs of " + name }
    
    var logs: [Log] {
        get {
            UserDefaults.standard.logs(forKey: userDefaultKey)
        }
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey: userDefaultKey)
                objectWillChange.send()
            }
        }
    }
    
    var tags: [Tag]
    
    init(named name: String) {
        self.name = name
        tags = TagList(named: name).tags
        if logs.isEmpty {
            logs = Log.test
        }
    }
    
    // MARK: Adding logs
    func insert(_ log: Log, at insertionIndex: Int? = nil) {
        let insertionIndex = insertionIndex ?? 0
        if let index = logs.firstIndex(where: { $0.id == log.id }) {
            logs.move(fromOffsets: IndexSet([index]), toOffset: insertionIndex)
            logs.replaceSubrange(insertionIndex...insertionIndex, with: [log])
        } else {
            logs.insert(log, at: insertionIndex)
        }
    }
    
    func insert(emotion: Emotion, tag: Tag, description: String, startDate: Date, endDate: Date, at index: Int? = nil) {
        insert(Log(emotion: emotion, tag: tag, description: description, startDate: startDate, endDate: endDate), at: index)
    }
    
    func append(_ log: Log) { // at end of logs
        if let index = logs.firstIndex(where: { $0.id == log.id }) {
            if logs.count == 1 {
                logs = [log]
            } else {
                logs.remove(at: index)
                logs.append(log)
            }
        } else {
            logs.append(log)
        }
    }
    
    func append(emotion: Emotion, tag: Tag, description: String, startDate: Date, endDate: Date) {
        append(Log(emotion: emotion, tag: tag, description: description, startDate: startDate, endDate: endDate))
    }
}


extension LogList: Hashable {
    static func == (lhs: LogList, rhs: LogList) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
}
