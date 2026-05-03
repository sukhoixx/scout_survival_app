import Foundation

struct Topic: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let icon: String
    let summary: String
    let subtopics: [Topic]
    let articles: [Article]
    let tags: [String]

    var hasChildren: Bool {
        !subtopics.isEmpty || !articles.isEmpty
    }

    static func == (lhs: Topic, rhs: Topic) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Article: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let content: String
    let tags: [String]
    let difficulty: Difficulty
    let priority: Priority
    let heroSymbol: String
    let heroColor: String

    enum CodingKeys: String, CodingKey {
        case id, title, content, tags, difficulty, priority
        case heroSymbol, heroColor
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id           = try c.decode(String.self, forKey: .id)
        title        = try c.decode(String.self, forKey: .title)
        content      = try c.decode(String.self, forKey: .content)
        tags         = try c.decode([String].self, forKey: .tags)
        difficulty   = try c.decode(Difficulty.self, forKey: .difficulty)
        priority     = try c.decode(Priority.self, forKey: .priority)
        heroSymbol   = try c.decodeIfPresent(String.self, forKey: .heroSymbol) ?? "doc.text.fill"
        heroColor    = try c.decodeIfPresent(String.self, forKey: .heroColor) ?? "green"
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(id, forKey: .id)
        try c.encode(title, forKey: .title)
        try c.encode(content, forKey: .content)
        try c.encode(tags, forKey: .tags)
        try c.encode(difficulty, forKey: .difficulty)
        try c.encode(priority, forKey: .priority)
        try c.encode(heroSymbol, forKey: .heroSymbol)
        try c.encode(heroColor, forKey: .heroColor)
    }

    enum Difficulty: String, Codable, CaseIterable {
        case basic = "Basic"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
    }

    enum Priority: String, Codable {
        case critical = "Critical"
        case high = "High"
        case medium = "Medium"
        case low = "Low"

        var color: String {
            switch self {
            case .critical: return "red"
            case .high: return "orange"
            case .medium: return "yellow"
            case .low: return "green"
            }
        }
    }
}
