//
//  ContextView.swift
//  HuggingChat-Mac
//
//  Created by Cyril Zakka on 12/4/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContextView: View {
    
    @Environment(ConversationViewModel.self) private var conversationModel
    @AppStorage("useContext") private var useContext: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            Image(nsImage: conversationModel.contextAppIcon ??
                  NSWorkspace.shared.icon(for: UTType.application))
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 16)
            VStack {
                Text("Working with \(conversationModel.contextAppName ?? "")")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: {
                conversationModel.clearContext()
                                useContext = false
            }, label: {
                Label("", systemImage: "xmark.circle.fill")
                    .labelStyle(.iconOnly)
            })
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 7)
        .padding(.horizontal, 7)
            .background(
                UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: 9,
                bottomLeading: 0,
                bottomTrailing: 0,
                topTrailing: 9),
                style: .continuous)
                .fill(.quaternary)
            )
    }
}

#Preview("dark") {
    ChatView()
        .frame(height: 300)
        .environment(ModelManager())
        .environment(ConversationViewModel())
        .environment(AudioModelManager())
        .colorScheme(.dark)
}