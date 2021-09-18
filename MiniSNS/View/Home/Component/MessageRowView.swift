//
//  MessageRowView.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import SwiftUI

struct MessageRowView: View {
    let message: Message
    let changeStar: (Bool) -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(message.userName)
                    .font(.headline)
                Text(message.text)
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            if message.isFavorite {
                Button {
                    changeStar(false)
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .accessibilityIdentifier("message_star_active")
                }
                .buttonStyle(BorderlessButtonStyle())
            } else {
                Button {
                    changeStar(true)
                } label: {
                    Image(systemName: "star")
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("message_star")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
}

#if DEBUG

struct MessageRowView_Previews: PreviewProvider {
    static var previews: some View {
        MessageRowView(
            message: Message(id: "id1", text: "Hellow!", userName: "nanashiki", isFavorite: true),
            changeStar: { _ in }
        )
    }
}

#endif
