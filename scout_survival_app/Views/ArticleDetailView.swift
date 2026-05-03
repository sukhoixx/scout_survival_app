import SwiftUI

// MARK: - Color name mapping

extension Color {
    static func named(_ name: String) -> Color {
        switch name {
        case "red":    return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green":  return .green
        case "teal":   return .teal
        case "cyan":   return .cyan
        case "blue":   return .blue
        case "indigo": return .indigo
        case "purple": return .purple
        case "brown":  return .brown
        case "gray":   return .gray
        default:       return .green
        }
    }
}

// MARK: - Article Detail View

struct ArticleDetailView: View {
    let article: Article
    @State private var fontSize: CGFloat = 16

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Hero banner
                ArticleHeroBanner(symbol: article.heroSymbol, colorName: article.heroColor, title: article.title)

                VStack(alignment: .leading, spacing: 20) {
                    // Header badges
                    HStack(spacing: 8) {
                        PriorityBadge(priority: article.priority)
                        DifficultyBadge(difficulty: article.difficulty)
                        Spacer()
                        FontSizeControl(fontSize: $fontSize)
                    }
                    .padding(.top, 4)

                    Divider()

                    FormattedContentView(
                        content: article.content,
                        fontSize: fontSize
                    )

                    if !article.tags.isEmpty {
                        Divider()
                        TagsView(tags: article.tags)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Hero Banner

struct ArticleHeroBanner: View {
    let symbol: String
    let colorName: String
    let title: String

    var heroColor: Color { .named(colorName) }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [heroColor.opacity(0.9), heroColor.opacity(0.5)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Decorative large background symbol
            Image(systemName: symbol)
                .font(.system(size: 120, weight: .thin))
                .foregroundStyle(.white.opacity(0.15))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
                .padding(.bottom, 10)

            // Foreground symbol + title
            HStack(alignment: .bottom, spacing: 14) {
                Image(systemName: symbol)
                    .font(.system(size: 44, weight: .medium))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .clipped()
    }
}

struct FormattedContentView: View {
    let content: String
    let fontSize: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(parsedBlocks, id: \.id) { block in
                ContentBlockView(block: block, fontSize: fontSize)
            }
        }
    }

    var parsedBlocks: [ContentBlock] {
        var blocks: [ContentBlock] = []
        let lines = content.components(separatedBy: "\n")
        var bulletItems: [String] = []

        func flushBullets() {
            if !bulletItems.isEmpty {
                blocks.append(ContentBlock(type: .bulletList(bulletItems)))
                bulletItems = []
            }
        }

        for line in lines {
            if line.hasPrefix("## ") {
                flushBullets()
                let heading = String(line.dropFirst(3))
                blocks.append(ContentBlock(type: .heading2(heading)))
            } else if line.hasPrefix("# ") {
                flushBullets()
                blocks.append(ContentBlock(type: .heading1(String(line.dropFirst(2)))))
            } else if line.hasPrefix("- ") || line.hasPrefix("• ") {
                bulletItems.append(String(line.dropFirst(2)))
            } else if line.hasPrefix("**") && line.hasSuffix("**") {
                flushBullets()
                blocks.append(ContentBlock(type: .bold(String(line.dropFirst(2).dropLast(2)))))
            } else if line.trimmingCharacters(in: .whitespaces).isEmpty {
                flushBullets()
            } else {
                flushBullets()
                blocks.append(ContentBlock(type: .paragraph(line)))
            }
        }
        flushBullets()
        return blocks
    }
}

struct ContentBlock: Identifiable {
    let id = UUID()
    enum BlockType {
        case heading1(String)
        case heading2(String)
        case paragraph(String)
        case bulletList([String])
        case bold(String)
    }
    let type: BlockType
}

struct ContentBlockView: View {
    let block: ContentBlock
    let fontSize: CGFloat

    var body: some View {
        switch block.type {
        case .heading1(let text):
            Text(text)
                .font(.system(size: fontSize + 6, weight: .bold))
        case .heading2(let text):
            Text(text)
                .font(.system(size: fontSize + 2, weight: .semibold))
                .foregroundColor(.green)
        case .paragraph(let text):
            Text(text)
                .font(.system(size: fontSize))
                .lineSpacing(4)
        case .bulletList(let items):
            VStack(alignment: .leading, spacing: 6) {
                ForEach(items, id: \.self) { item in
                    HStack(alignment: .top, spacing: 8) {
                        Text("•")
                            .foregroundColor(.green)
                            .font(.system(size: fontSize))
                        Text(item)
                            .font(.system(size: fontSize))
                            .lineSpacing(3)
                    }
                }
            }
        case .bold(let text):
            Text(text)
                .font(.system(size: fontSize, weight: .semibold))
        }
    }
}

struct TagsView: View {
    let tags: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Tags")
                .font(.caption.bold())
                .foregroundColor(.secondary)
            FlowLayout(spacing: 6) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.1))
                        .foregroundColor(.green)
                        .clipShape(Capsule())
                }
            }
        }
    }
}

struct FontSizeControl: View {
    @Binding var fontSize: CGFloat

    var body: some View {
        HStack(spacing: 4) {
            Button { fontSize = max(12, fontSize - 2) } label: {
                Image(systemName: "textformat.size.smaller")
                    .foregroundColor(.secondary)
            }
            Button { fontSize = min(24, fontSize + 2) } label: {
                Image(systemName: "textformat.size.larger")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.replacingUnspecifiedDimensions().width, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y), proposal: .unspecified)
        }
    }

    struct FlowResult {
        var positions: [CGPoint] = []
        var size: CGSize = .zero

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var rowHeight: CGFloat = 0
            var maxX: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                if x + size.width > maxWidth, x > 0 {
                    x = 0
                    y += rowHeight + spacing
                    rowHeight = 0
                }
                positions.append(CGPoint(x: x, y: y))
                x += size.width + spacing
                rowHeight = max(rowHeight, size.height)
                maxX = max(maxX, x)
            }
            self.size = CGSize(width: maxX, height: y + rowHeight)
        }
    }
}
