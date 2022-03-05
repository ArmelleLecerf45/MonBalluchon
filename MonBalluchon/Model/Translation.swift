//
//  Translation.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 01/12/2021.
//

import Foundation
struct Datas: Codable {
    let data: Texts
}

struct Texts: Codable {
    let translations: [TextToTranslateAndTarget]
}

struct TextToTranslateAndTarget: Codable {
    let translatedText: String
    let detectedSourceLanguage: String
}
