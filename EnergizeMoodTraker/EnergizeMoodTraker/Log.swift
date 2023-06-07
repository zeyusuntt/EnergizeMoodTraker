//
//  Log.swift
//  EnergizeMoodTraker
//
//  Created by 孙泽宇 on 6/6/23.
//

import Foundation

struct Log: Identifiable, Codable, Hashable {
    var emotion: String
    var tag: String
    var description: String
    var startDate: Date
    var endDate: Date
    var id = UUID()
    
    static var test: [Log] { [
        Log(emotion: "good", tag: "family", description: "hiahia", startDate: Date(), endDate: Date()),
        Log(emotion: "not bad", tag: "health", description: "sleepy", startDate: Date(), endDate: Date()),
        Log(emotion: "bad", tag: "study", description: "tired", startDate: Date(), endDate: Date())
    ]}
}

