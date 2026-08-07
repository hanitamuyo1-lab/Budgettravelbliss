import SwiftUI

struct DestinationDetailView: View {
    let destination: Destination
    let isSaved: Bool
    let toggle: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Color(.secondarySystemBackground)
                    .frame(maxWidth: .infinity)
                    .frame(height: 240)
                    .overlay {
                        AsyncImage(url: destination.photoURL) { img in
                            img.resizable().scaledToFill()
                        } placeholder: {
                            Color(.secondarySystemBackground)
                        }
                    }
                    .clipped()

                VStack(alignment: .leading, spacing: 14) {
                    Text(destination.name).font(.largeTitle.bold())
                    Text("\(destination.country) · \(destination.region)")
                        .foregroundStyle(.secondary)
                    Text(destination.tagline).font(.body)

                    Divider()

                    factRow("Daily budget", "$\(destination.dailyCost)")
                    factRow("Rating", "★ \(String(format: "%.1f", destination.rating)) (\(destination.reviews) reviews)")
                    factRow("Best time", destination.bestTime)
                    factRow("Climate", destination.climate)
                    factRow("Language", destination.lang)
                    factRow("Currency", destination.currency)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: toggle) {
                    Image(systemName: isSaved ? "heart.fill" : "heart")
                        .foregroundStyle(.pink)
                }
            }
        }
    }

    private func factRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label).foregroundStyle(.secondary)
            Spacer()
            Text(value).fontWeight(.medium)
        }
    }
}
