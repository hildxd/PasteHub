import Foundation

enum ClipboardContentType: String, Codable {
    case text
    case image
    case file

    var icon: String {
        switch self {
        case .text:  return "doc.text"
        case .image: return "photo"
        case .file:  return "doc"
        }
    }

    var label: String {
        switch self {
        case .text:  return "文本"
        case .image: return "图片"
        case .file:  return "文件"
        }
    }
}

struct ClipboardItem: Identifiable, Codable {
    let id: UUID
    let type: ClipboardContentType
    let content: String
    let timestamp: Date
    let sourceApp: String?
    let sourceBundleIdentifier: String?

    init(
        id: UUID = UUID(),
        type: ClipboardContentType,
        content: String,
        timestamp: Date = Date(),
        sourceApp: String? = nil,
        sourceBundleIdentifier: String? = nil
    ) {
        self.id = id
        self.type = type
        self.content = content
        self.timestamp = timestamp
        self.sourceApp = sourceApp
        self.sourceBundleIdentifier = sourceBundleIdentifier
    }

    var displayText: String {
        switch type {
        case .text:
            return String(content.prefix(200))
        case .image:
            return "[图片]"
        case .file:
            return contentURL?.lastPathComponent ?? content
        }
    }

    var contentURL: URL? {
        if let url = URL(string: content) {
            return url
        }
        if content.hasPrefix("/") {
            return URL(fileURLWithPath: content)
        }
        return nil
    }
}
