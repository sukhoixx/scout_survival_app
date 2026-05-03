import SwiftUI

struct SearchView: View {
    @EnvironmentObject var dataStore: SurvivalDataStore
    @State private var query = ""
    @State private var filter: SearchFilter = .all
    @State private var results: (topics: [Article], injuries: [Injury]) = ([], [])

    enum SearchFilter: String, CaseIterable {
        case all = "All"
        case topics = "Topics"
        case injuries = "Injuries"
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Filter picker
                Picker("Filter", selection: $filter) {
                    ForEach(SearchFilter.allCases, id: \.self) { f in
                        Text(f.rawValue).tag(f)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                if query.isEmpty {
                    SearchPlaceholderView()
                } else if results.topics.isEmpty && results.injuries.isEmpty {
                    ContentUnavailableView(
                        "No Results",
                        systemImage: "magnifyingglass",
                        description: Text("Try a different search term")
                    )
                } else {
                    List {
                        if (filter == .all || filter == .topics), !results.topics.isEmpty {
                            Section("Articles (\(results.topics.count))") {
                                ForEach(results.topics) { article in
                                    NavigationLink(destination: ArticleDetailView(article: article)) {
                                        ArticleRowView(article: article, query: query)
                                    }
                                }
                            }
                        }

                        if (filter == .all || filter == .injuries), !results.injuries.isEmpty {
                            Section("Injuries & Illnesses (\(results.injuries.count))") {
                                ForEach(results.injuries) { injury in
                                    NavigationLink(destination: InjuryDetailView(injury: injury)) {
                                        InjuryRowView(injury: injury)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Search")
            .searchable(text: $query, prompt: "Search topics, injuries, symptoms...")
            .onChange(of: query) { _, newValue in
                results = dataStore.search(query: newValue)
            }
        }
    }
}

struct SearchPlaceholderView: View {
    let suggestions = ["Hypothermia", "Snake bite", "Fire starting", "Water purification", "Broken bone", "Blister"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Quick Searches")
                    .font(.subheadline.bold())
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                FlowLayout(spacing: 8) {
                    ForEach(suggestions, id: \.self) { suggestion in
                        Text(suggestion)
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 20)
        }
    }
}

struct ArticleRowView: View {
    let article: Article
    let query: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(article.title)
                .font(.body.bold())
            HStack(spacing: 6) {
                PriorityBadge(priority: article.priority)
                DifficultyBadge(difficulty: article.difficulty)
            }
            if let excerpt = article.content.excerpt(containing: query) {
                Text(excerpt)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 2)
    }
}

struct InjuryRowView: View {
    let injury: Injury

    var severityColor: Color {
        switch injury.severity {
        case .minor: return .green
        case .moderate: return .yellow
        case .serious: return .orange
        case .lifeThreatening: return .red
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: injury.category.icon)
                .foregroundColor(severityColor)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 3) {
                Text(injury.name)
                    .font(.body.bold())
                HStack(spacing: 6) {
                    Text(injury.severity.rawValue)
                        .font(.caption2.bold())
                        .foregroundColor(severityColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(severityColor.opacity(0.12))
                        .clipShape(Capsule())
                    Text(injury.category.rawValue)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Text(injury.symptoms.prefix(3).joined(separator: ", "))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 2)
    }
}

extension String {
    func excerpt(containing keyword: String, radius: Int = 60) -> String? {
        let lower = self.lowercased()
        let kw = keyword.lowercased()
        guard let range = lower.range(of: kw) else { return nil }
        let start = lower.index(range.lowerBound, offsetBy: -min(radius, lower.distance(from: lower.startIndex, to: range.lowerBound)), limitedBy: lower.startIndex) ?? lower.startIndex
        let end = lower.index(range.upperBound, offsetBy: min(radius, lower.distance(from: range.upperBound, to: lower.endIndex)), limitedBy: lower.endIndex) ?? lower.endIndex
        let excerpt = String(self[start..<end])
        return (start > lower.startIndex ? "..." : "") + excerpt + (end < lower.endIndex ? "..." : "")
    }
}
