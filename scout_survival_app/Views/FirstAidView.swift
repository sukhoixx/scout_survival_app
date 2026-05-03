import SwiftUI

struct FirstAidView: View {
    @EnvironmentObject var dataStore: SurvivalDataStore
    @State private var selectedCategory: Injury.InjuryCategory? = nil

    var filteredInjuries: [Injury] {
        guard let cat = selectedCategory else { return dataStore.injuries }
        return dataStore.injuries.filter { $0.category == cat }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Category scroll filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        CategoryChip(title: "All", icon: "list.bullet", isSelected: selectedCategory == nil) {
                            selectedCategory = nil
                        }
                        ForEach(Injury.InjuryCategory.allCases, id: \.self) { cat in
                            CategoryChip(title: cat.rawValue, icon: cat.icon, isSelected: selectedCategory == cat) {
                                selectedCategory = selectedCategory == cat ? nil : cat
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .background(Color(.systemGroupedBackground))

                // Injuries grouped by severity
                List {
                    ForEach(Injury.Severity.allCases.reversed(), id: \.self) { severity in
                        let items = filteredInjuries.filter { $0.severity == severity }
                        if !items.isEmpty {
                            Section {
                                ForEach(items) { injury in
                                    NavigationLink(destination: InjuryDetailView(injury: injury)) {
                                        InjuryRowView(injury: injury)
                                    }
                                }
                            } header: {
                                SeverityHeader(severity: severity, count: items.count)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("First Aid")
        }
    }
}

struct CategoryChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption)
                Text(title)
                    .font(.caption.bold())
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(isSelected ? Color.green : Color(.systemGray5))
            .foregroundColor(isSelected ? .white : .primary)
            .clipShape(Capsule())
        }
    }
}

struct SeverityHeader: View {
    let severity: Injury.Severity
    let count: Int

    var color: Color {
        switch severity {
        case .minor: return .green
        case .moderate: return .yellow
        case .serious: return .orange
        case .lifeThreatening: return .red
        }
    }

    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(severity.rawValue)
                .font(.subheadline.bold())
                .foregroundColor(color)
            Spacer()
            Text("\(count) conditions")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
