import SwiftUI
import SwiftData

struct DestinationsView: View {
    @Environment(\.modelContext) private var context
    @Query private var saved: [SavedDestination]

    @State private var search = ""
    @State private var region = "All"

    private var filtered: [Destination] {
        DestinationStore.all.filter { d in
            (region == "All" || d.region == region) &&
            (search.isEmpty ||
             d.name.localizedCaseInsensitiveContains(search) ||
             d.country.localizedCaseInsensitiveContains(search))
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Picker("Region", selection: $region) {
                    ForEach(DestinationStore.regions, id: \.self) { Text($0) }
                }
                .pickerStyle(.segmented)
                .listRowSeparator(.hidden)

                ForEach(filtered) { d in
                    NavigationLink(value: d) {
                        DestinationRow(destination: d, isSaved: isSaved(d))
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Destinations")
            .searchable(text: $search, prompt: "Search city or country")
            .navigationDestination(for: Destination.self) { d in
                DestinationDetailView(destination: d, isSaved: isSaved(d), toggle: { toggle(d) })
            }
        }
    }

    private func isSaved(_ d: Destination) -> Bool {
        saved.contains { $0.destinationID == d.id }
    }

    private func toggle(_ d: Destination) {
        if let existing = saved.first(where: { $0.destinationID == d.id }) {
            context.delete(existing)
        } else {
            context.insert(SavedDestination(from: d))
        }
    }
}

struct DestinationRow: View {
    let destination: Destination
    let isSaved: Bool

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: destination.photoURL) { img in
                img.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle().fill(.quaternary)
            }
            .frame(width: 64, height: 64)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 3) {
                Text(destination.name).font(.headline)
                Text(destination.country).font(.subheadline).foregroundStyle(.secondary)
                Text("$\(destination.dailyCost)/day · ★ \(destination.rating, specifier: "%.1f")")
                    .font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            if isSaved {
                Image(systemName: "heart.fill").foregroundStyle(.pink).font(.footnote)
            }
        }
        .padding(.vertical, 4)
    }
}
