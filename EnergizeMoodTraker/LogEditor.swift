//
//  LogEditor.swift
//  EnergizeMoodTraker
//
//  Created by 孙泽宇 on 6/7/23.
//

import SwiftUI

struct LogEditor: View {
    @Binding var log: Log
    var body: some View {
        Text("Hello, World! \(log.emotion)")
    }
}

struct LogEditor_Previews: PreviewProvider {
    struct Preview: View {
        @State private var log = Log(emotion: "good", tag: "health", description: "nothing", startDate: Date(), endDate: Date())
        var body: some View {
            LogEditor(log: $log)
        }
        
    }
    static var previews: some View {
        
        Preview()
    }
}
