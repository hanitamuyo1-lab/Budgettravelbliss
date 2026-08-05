import SwiftUI
import SwiftData

struct SavedView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \SavedDestination.savedAt, order: .reverse) private var saved: [SavedDestination]

    var body: some View {
        NavigationStack {
            Group {
                if saved.isEmpty {
                    ContentUnavailableView(
                        "No saved destinations",
                        systemImage: "heart",
                        description: Text("Tap the heart on any destination to save it here for offline access.")
                    )
                } else {
                    List {
                        ForEach(saved) { item in
                            HStack(spacing: 12) {
                                AsyncImage(url: URL(string: item.photo)) { img in
                                    img.resizable().aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Rectangle().fill(.quaternary)
                                }
                                .frame(width: 56, height: 56)
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                                VStack(alignment: .leading, spacing: 3) {
                                    Text(item.name).font(.headline)
                                    Text("\(item.country) · $\(item.dailyCost)/day")
                                        .font(.subheadline).foregroundStyle(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Saved")
        }
    }

    private func delete(_ offsets: IndexSet) {
        for i in offsets { context.delete(saved[i]) }
    }
}
