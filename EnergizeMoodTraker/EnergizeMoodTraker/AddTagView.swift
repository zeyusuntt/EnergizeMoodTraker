//
//  AddTagView.swift
//  EnergizeMoodTraker
//
//  Created by 孙泽宇 on 6/7/23.
//

import SwiftUI

struct AddTagView: View {
    @Environment(\.presentationMode) private var presentationMode
        @EnvironmentObject var tagList: TagList
        @State private var newTagEmoji = ""
        @State private var newTagName = ""
        @State private var newTagCategory = ""
    var body: some View {
            VStack {
                TextField("Emoji", text: $newTagEmoji)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Name", text: $newTagName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Category", text: $newTagCategory)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: addNewTag) {
                    Text("Add Tag")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        
        func addNewTag() {
            let newTag = Tag(emoji: newTagEmoji, name: newTagName, category: newTagCategory)
            tagList.tags.append(newTag)
            presentationMode.wrappedValue.dismiss()
        }
}
//
//struct AddTagView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTagView()
//    }
//}
