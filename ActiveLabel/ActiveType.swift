//
//  ActiveType.swift
//  ActiveLabel
//
//  Created by Johannes Schickling on 9/4/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

enum ActiveElement {
    case mention(String)
    case hashtag(String)
    case header(String)
    case url(original: String, trimmed: String)
    case bold(String)
    case italic(String)
    case custom(String)
    
    static func create(with activeType: ActiveType, text: String) -> ActiveElement {
        switch activeType {
        case .mention: return mention(text)
        case .hashtag: return hashtag(text)
        case .header: return header(text)
        case .url: return url(original: text, trimmed: text)
        case .bold: return bold(text)
        case .italic: return italic(text)
        case .custom: return custom(text)
        }
    }
}

public enum ActiveType {
    case mention
    case hashtag
    case header
    case url
    case bold
    case italic
    case custom(pattern: String)
    
    var pattern: String {
        switch self {
        case .mention: return RegexParser.mentionPattern
        case .hashtag: return RegexParser.hashtagPattern
        case .header: return RegexParser.headerPattern
        case .url: return RegexParser.urlPattern
        case .bold: return RegexParser.boldPattern
        case .italic: return RegexParser.italicPattern
        case .custom(let regex): return regex
        }
    }
}

extension ActiveType: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .mention: hasher.combine(-1)
        case .hashtag: hasher.combine(-2)
        case .url: hasher.combine(-3)
        case .bold: hasher.combine(-4)
        case .header: hasher.combine(-5)
        case .italic: hasher.combine(-6)
        case .custom(let regex): hasher.combine(regex)
        }
    }
}

public func ==(lhs: ActiveType, rhs: ActiveType) -> Bool {
    switch (lhs, rhs) {
    case (.mention, .mention): return true
    case (.hashtag, .hashtag): return true
    case (.header, .header): return true
    case (.url, .url): return true
    case (.bold, .bold): return true
    case (.italic, .italic): return true
    case (.custom(let pattern1), .custom(let pattern2)): return pattern1 == pattern2
    default: return false
    }
}
