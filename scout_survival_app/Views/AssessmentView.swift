import SwiftUI

struct AssessmentView: View {
    @EnvironmentObject var dataStore: SurvivalDataStore
    @State private var selectedSymptoms: Set<String> = []
    @State private var showResults = false
    @State private var symptomQuery = ""

    var filteredSymptoms: [Symptom] {
        let symptoms = dataStore.allSymptoms
        if symptomQuery.isEmpty { return symptoms }
        return symptoms.filter { $0.name.lowercased().contains(symptomQuery.lowercased()) }
    }

    var groupedSymptoms: [(category: String, symptoms: [Symptom])] {
        let grouped = Dictionary(grouping: filteredSymptoms) { $0.category }
        return grouped.map { (category: $0.key, symptoms: $0.value.sorted { $0.name < $1.name }) }
            .sorted { $0.category < $1.category }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Instructions banner
                VStack(alignment: .leading, spacing: 4) {
                    Text("Symptom Assessment")
                        .font(.subheadline.bold())
                    Text("Select all symptoms to identify possible conditions and treatments")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGroupedBackground))

                // Selected symptoms count + assess button
                if !selectedSymptoms.isEmpty {
                    HStack {
                        Label("\(selectedSymptoms.count) symptom(s) selected", systemImage: "checkmark.circle.fill")
                            .font(.subheadline)
                            .foregroundColor(.green)
                        Spacer()
                        Button("Analyze") {
                            showResults = true
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)

                        Button {
                            selectedSymptoms.removeAll()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemBackground))
                    .overlay(Divider(), alignment: .bottom)
                }

                // Symptom search + list
                List {
                    ForEach(groupedSymptoms, id: \.category) { group in
                        Section(group.category) {
                            ForEach(group.symptoms) { symptom in
                                SymptomToggleRow(
                                    symptom: symptom,
                                    isSelected: selectedSymptoms.contains(symptom.id)
                                ) {
                                    if selectedSymptoms.contains(symptom.id) {
                                        selectedSymptoms.remove(symptom.id)
                                    } else {
                                        selectedSymptoms.insert(symptom.id)
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .searchable(text: $symptomQuery, prompt: "Search symptoms...")
            }
            .navigationTitle("Assess")
            .navigationDestination(isPresented: $showResults) {
                AssessmentResultsView(
                    results: dataStore.assess(selectedSymptomIDs: selectedSymptoms),
                    selectedCount: selectedSymptoms.count
                )
            }
        }
    }
}

struct SymptomToggleRow: View {
    let symptom: Symptom
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .green : .secondary)
                    .font(.title3)
                Text(symptom.name)
                    .foregroundColor(.primary)
                Spacer()
            }
        }
    }
}

struct AssessmentResultsView: View {
    let results: [ConditionProbability]
    let selectedCount: Int

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Summary header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Based on \(selectedCount) selected symptom(s), found \(results.count) possible condition(s).")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("This is a guide only. Always consult medical professionals.")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal)

                if results.isEmpty {
                    ContentUnavailableView(
                        "No Matches Found",
                        systemImage: "questionmark.circle",
                        description: Text("Try selecting different symptoms")
                    )
                } else {
                    ForEach(results) { result in
                        NavigationLink(destination: InjuryDetailView(injury: result.condition)) {
                            ProbabilityResultCard(result: result)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Results")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProbabilityResultCard: View {
    let result: ConditionProbability

    var confidenceColor: Color {
        switch result.confidence {
        case .high: return .green
        case .medium: return .orange
        case .low: return .red
        }
    }

    var severityColor: Color {
        switch result.condition.severity {
        case .minor: return .green
        case .moderate: return .yellow
        case .serious: return .orange
        case .lifeThreatening: return .red
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: result.condition.category.icon)
                    .foregroundColor(severityColor)
                Text(result.condition.name)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            // Probability bar
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Match probability")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(String(format: "%.0f%%", result.probability * 100))
                        .font(.caption.bold())
                        .foregroundColor(confidenceColor)
                    Text("(\(result.confidence.rawValue))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(.systemGray5))
                            .frame(height: 8)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(confidenceColor.gradient)
                            .frame(width: geo.size.width * result.probability, height: 8)
                    }
                }
                .frame(height: 8)
            }

            // Matched symptoms
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.caption)
                    .foregroundColor(.green)
                Text("Matched: \(result.matchedSymptoms.joined(separator: ", "))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }

            HStack(spacing: 8) {
                Text(result.condition.severity.rawValue)
                    .font(.caption2.bold())
                    .foregroundColor(severityColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(severityColor.opacity(0.12))
                    .clipShape(Capsule())
                Text(result.condition.category.rawValue)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.07), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(confidenceColor.opacity(0.3), lineWidth: 1)
        )
    }
}
