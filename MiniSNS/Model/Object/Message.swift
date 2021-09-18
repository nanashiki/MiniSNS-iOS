//
//  Message.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import Foundation

struct Message: Identifiable, Equatable {
    let id: String
    let text: String
    let userName: String
    let isFavorite: Bool
}
