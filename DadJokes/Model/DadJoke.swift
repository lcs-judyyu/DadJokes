//
//  DadJoke.swift
//  DadJokes
//
//  Created by Judy Yu on 2022-02-22.
//

import Foundation

//conforms to the decodable protocol
struct DadJoke: Decodable, Hashable {
    let id: String
    let joke: String
    let status: Int
}
