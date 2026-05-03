import Foundation

struct Injury: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let category: InjuryCategory
    let severity: Severity
    let symptoms: [String]
    let immediateActions: [String]
    let treatments: [Treatment]
    let warningSigns: [String]
    let whenToEvacuate: String
    let preventionTips: [String]

    enum InjuryCategory: String, Codable, CaseIterable {
        case trauma = "Trauma"
        case environmental = "Environmental"
        case illness = "Illness"
        case biteAndSting = "Bites & Stings"
        case wound = "Wounds"
        case musculoskeletal = "Musculoskeletal"
        case neurological = "Neurological"

        var icon: String {
            switch self {
            case .trauma: return "bolt.heart.fill"
            case .environmental: return "thermometer.sun.fill"
            case .illness: return "allergens.fill"
            case .biteAndSting: return "ant.fill"
            case .wound: return "bandage.fill"
            case .musculoskeletal: return "figure.walk"
            case .neurological: return "brain.head.profile"
            }
        }
    }

    enum Severity: String, Codable, CaseIterable {
        case minor = "Minor"
        case moderate = "Moderate"
        case serious = "Serious"
        case lifeThreatening = "Life-Threatening"

        var colorName: String {
            switch self {
            case .minor: return "green"
            case .moderate: return "yellow"
            case .serious: return "orange"
            case .lifeThreatening: return "red"
            }
        }
    }
}

struct Treatment: Identifiable, Codable, Hashable {
    let id: String
    let step: Int
    let description: String
    let materials: [String]
    let notes: String?
}
