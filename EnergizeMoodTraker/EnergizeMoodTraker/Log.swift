//
//  Log.swift
//  EnergizeMoodTraker
//
//  Created by 孙泽宇 on 6/6/23.
//

import Foundation

struct Log: Identifiable, Codable, Hashable {
    var emotion: Emotion
    var tag: Tag
    var description: String
    var startDate: Date
    var endDate: Date
    var id = UUID()
    
    static var test: [Log] { [
        
        Log(emotion: Emotion(emoji: "😆", name: "Thrilled"), tag: Tag(emoji: "👨‍👩‍👧‍👦", name: "family", category: "Social"), description: "hiahia", startDate: Date(), endDate: Date()),
        Log(emotion: Emotion(emoji: "😊", name: "Happpy"), tag: Tag(emoji: "👩‍❤️‍👩", name: "friends", category: "Social"), description: "sleepy", startDate: Date(), endDate: Date()),
        Log(emotion: Emotion(emoji: "☹️", name: "Bad"), tag: Tag(emoji: "🍷", name: "date", category: "Social"), description: "tired", startDate: Date(), endDate: Date())
    ]}
}

struct Emotion: Identifiable, Codable, Hashable {
    let emoji: String
    let name: String
    var id = UUID()
    
    
    static var emotionList: [Emotion] {[
        Emotion(emoji: "😆", name: "Thrilled"),
        Emotion(emoji: "😊", name: "Good"),
        Emotion(emoji: "🙂", name: "Meh"),
        Emotion(emoji: "☹️", name: "Bad"),
        Emotion(emoji: "😫", name: "Awful")
    ]}
}
