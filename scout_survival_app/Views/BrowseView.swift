import SwiftUI

struct BrowseView: View {
    @EnvironmentObject var dataStore: SurvivalDataStore
    let columns = [GridItem(.adaptive(minimum: 150), spacing: 16)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Hero banner
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(
                                colors: [Color.green.opacity(0.8), Color.green.opacity(0.4)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                        VStack(spacing: 8) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                            Text("Scout Survival Guide")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            Text("Offline wilderness resource")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                    .padding(.horizontal)

                    // Topics grid
                    Text("Survival Topics")
                        .font(.headline)
                        .padding(.horizontal)

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(dataStore.topics) { topic in
                            NavigationLink(destination: TopicDetailView(topic: topic)) {
                                TopicCardView(topic: topic)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct TopicCardView: View {
    let topic: Topic

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: topic.icon)
                .font(.system(size: 32))
                .foregroundColor(.green)
                .frame(width: 60, height: 60)
                .background(Color.green.opacity(0.1))
                .clipShape(Circle())

            Text(topic.title)
                .font(.subheadline.bold())
                .multilineTextAlignment(.center)
                .lineLimit(2)

            Text(topic.summary)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)

            if !topic.subtopics.isEmpty || !topic.articles.isEmpty {
                Text("\(topic.subtopics.count + topic.articles.count) items")
                    .font(.caption2)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 2)
    }
}
