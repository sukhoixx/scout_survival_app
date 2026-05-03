import SwiftUI

struct TopicDetailView: View {
    let topic: Topic

    var body: some View {
        List {
            if !topic.summary.isEmpty {
                Section {
                    Text(topic.summary)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }

            if !topic.subtopics.isEmpty {
                Section("Subtopics") {
                    ForEach(topic.subtopics) { sub in
                        NavigationLink(destination: TopicDetailView(topic: sub)) {
                            HStack(spacing: 12) {
                                Image(systemName: sub.icon)
                                    .foregroundColor(.green)
                                    .frame(width: 28)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(sub.title)
                                        .font(.body.bold())
                                    if !sub.summary.isEmpty {
                                        Text(sub.summary)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }

            if !topic.articles.isEmpty {
                Section("Articles") {
                    ForEach(topic.articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            HStack(spacing: 12) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(article.title)
                                        .font(.body)
                                    HStack(spacing: 6) {
                                        PriorityBadge(priority: article.priority)
                                        DifficultyBadge(difficulty: article.difficulty)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.vertical, 2)
                        }
                    }
                }
            }
        }
        .navigationTitle(topic.title)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct PriorityBadge: View {
    let priority: Article.Priority

    var color: Color {
        switch priority {
        case .critical: return .red
        case .high: return .orange
        case .medium: return .yellow
        case .low: return .green
        }
    }

    var body: some View {
        Text(priority.rawValue)
            .font(.caption2.bold())
            .foregroundColor(color)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.12))
            .clipShape(Capsule())
    }
}

struct DifficultyBadge: View {
    let difficulty: Article.Difficulty

    var body: some View {
        Text(difficulty.rawValue)
            .font(.caption2)
            .foregroundColor(.secondary)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color(.systemGray5))
            .clipShape(Capsule())
    }
}
