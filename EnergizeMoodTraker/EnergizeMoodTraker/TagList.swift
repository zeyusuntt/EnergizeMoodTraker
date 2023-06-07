//
//  TagList.swift
//  EnergizeMoodTraker
//
//  Created by 孙泽宇 on 6/7/23.
//

import Foundation

extension UserDefaults {
    func tags(forKey key: String) -> [Tag] {
        if let jsonData = data(forKey: key),
           let decodedTags = try? JSONDecoder().decode([Tag].self, from: jsonData) {
            return decodedTags
        } else {
            return []
        }
    }
    func set(_ tags: [Tag], forKey key: String) {
        let data = try? JSONEncoder().encode(tags)
        set(data, forKey: key)
    }
}


struct Tag: Identifiable, Codable, Hashable {
    let emoji: String
    let name: String
    let category: String
    var id = UUID()
    
    static var builtins: [Tag] {[
    Tag(emoji: "👨‍👩‍👧‍👦", name: "family", category: "Social"),
    Tag(emoji: "👩‍❤️‍👩", name: "friends", category: "Social"),
    Tag(emoji: "🍷", name: "date", category: "Social"),
    Tag(emoji: "🎮", name: "gaming", category: "Hobbies"),
    Tag(emoji: "🎬", name: "movies", category: "Hobbies"),
    Tag(emoji: "🎼", name: "music", category: "Hobbies"),
    Tag(emoji: "🛌", name: "good sleep", category: "Sleep"),
    Tag(emoji: "🛏️", name: "medium sleep", category: "Sleep"),
    Tag(emoji: "☠️", name: "bad sleep", category: "Sleep"),
    Tag(emoji: "🏃‍♀️", name: "exercise", category: "Health"),
    Tag(emoji: "🥦", name: "eat healthy", category: "Health"),
    Tag(emoji: "🫖", name: "drink water", category: "Health"),
    Tag(emoji: "🧘‍♀️", name: "meditation", category: "Better Me"),
    Tag(emoji: "🎁", name: "gift", category: "Better Me")
    ]}
}

class TagList: ObservableObject {
    let name: String
    
    private var userDefaultsKey: String {"TagList" + name}
    var tags: [Tag] {
        get {
            UserDefaults.standard.tags(forKey: userDefaultsKey)
        }
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
                objectWillChange.send()
            }
        }
    }
    
    init(named name: String) {
        self.name = name
        if tags.isEmpty {
            tags = Tag.builtins
        }
    }
}
