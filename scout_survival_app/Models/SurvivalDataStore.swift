import Foundation
import Combine

class SurvivalDataStore: ObservableObject {
    @Published var topics: [Topic] = []
    @Published var injuries: [Injury] = []
    @Published var allSymptoms: [Symptom] = []
    @Published var isLoaded = false

    init() {
        loadData()
    }

    private func loadData() {
        topics = loadJSON("survival_topics", as: [Topic].self) ?? []
        injuries = loadJSON("injuries", as: [Injury].self) ?? []
        allSymptoms = extractSymptoms()
        isLoaded = true
    }

    private func loadJSON<T: Decodable>(_ filename: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load \(filename).json")
            return nil
        }
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("Failed to decode \(filename).json: \(error)")
            return nil
        }
    }

    private func extractSymptoms() -> [Symptom] {
        var symptomMap: [String: Symptom] = [:]
        for injury in injuries {
            for (i, symptom) in injury.symptoms.enumerated() {
                let key = symptom.lowercased()
                if symptomMap[key] == nil {
                    symptomMap[key] = Symptom(
                        id: key,
                        name: symptom,
                        category: injury.category.rawValue,
                        weight: Double(i == 0 ? 2 : 1)
                    )
                }
            }
        }
        return Array(symptomMap.values).sorted { $0.name < $1.name }
    }

    func assess(selectedSymptomIDs: Set<String>) -> [ConditionProbability] {
        guard !selectedSymptomIDs.isEmpty else { return [] }

        return injuries.compactMap { injury in
            let injurySymptomIDs = Set(injury.symptoms.map { $0.lowercased() })
            let matched = selectedSymptomIDs.intersection(injurySymptomIDs)
            guard !matched.isEmpty else { return nil }

            let probability = Double(matched.count) / Double(max(injurySymptomIDs.count, selectedSymptomIDs.count))
            let confidence: ConditionProbability.Confidence
            switch probability {
            case 0.6...: confidence = .high
            case 0.3...: confidence = .medium
            default: confidence = .low
            }

            return ConditionProbability(
                condition: injury,
                probability: probability,
                matchedSymptoms: Array(matched),
                confidence: confidence
            )
        }
        .sorted { $0.probability > $1.probability }
        .prefix(10)
        .map { $0 }
    }

    func search(query: String) -> (topics: [Article], injuries: [Injury]) {
        let q = query.lowercased()
        guard !q.isEmpty else { return ([], []) }

        let matchedArticles = allArticles().filter {
            $0.title.lowercased().contains(q) ||
            $0.content.lowercased().contains(q) ||
            $0.tags.contains(where: { $0.lowercased().contains(q) })
        }

        let matchedInjuries = injuries.filter {
            $0.name.lowercased().contains(q) ||
            $0.symptoms.contains(where: { $0.lowercased().contains(q) }) ||
            $0.category.rawValue.lowercased().contains(q)
        }

        return (matchedArticles, matchedInjuries)
    }

    private func allArticles() -> [Article] {
        var articles: [Article] = []
        func collect(_ topics: [Topic]) {
            for topic in topics {
                articles.append(contentsOf: topic.articles)
                collect(topic.subtopics)
            }
        }
        collect(topics)
        return articles
    }
}
