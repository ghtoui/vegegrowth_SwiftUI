//
//  JsonParser.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/19.
//

import Foundation

class JsonParser {
    // 与えられたjson文字列を指定の型に変換する
    func parseFromJson<T: Codable>(json: String) -> T {
        guard let data = json.data(using: .utf8) else {
            fatalError("jsonエラー")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("jsonエラー")
        }
    }
    
    // 与えられたものをjson文字列に変換
    func parseToJson<T: Codable>(item: T) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(item)
            guard let jsonData = String(data: jsonData, encoding: .utf8) else {
                fatalError("jsonエラー")
            }
            return jsonData
        } catch {
            fatalError("jsonエラー")
        }
    }
}
