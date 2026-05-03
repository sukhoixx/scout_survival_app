import Foundation

struct Symptom: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let category: String
    let weight: Double
}

struct ConditionProbability: Identifiable {
    let id = UUID()
    let condition: Injury
    let probability: Double
    let matchedSymptoms: [String]
    let confidence: Confidence

    enum Confidence: String {
        case high = "High"
        case medium = "Medium"
        case low = "Low"

        var colorName: String {
            switch self {
            case .high: return "green"
            case .medium: return "orange"
            case .low: return "red"
            }
        }
    }
}

struct AssessmentSession: Identifiable {
    let id = UUID()
    var selectedSymptoms: Set<String> = []
    var results: [ConditionProbability] = []
    let timestamp = Date()
}
