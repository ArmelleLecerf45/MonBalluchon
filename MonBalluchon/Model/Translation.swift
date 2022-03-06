//
//  Translation.swift
//  MonBalluchon
//
//  Created by macmini-Armelle on 01/12/2021.
//

import Foundation
struct Datas: Decodable {
    let data: Texts
}

struct Texts: Decodable {
    let translations: [TextToTranslateAndTarget]
}

struct TextToTranslateAndTarget: Decodable {
    let translatedText: String
    let detectedSourceLanguage: String
}
