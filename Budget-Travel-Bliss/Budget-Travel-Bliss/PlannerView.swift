import SwiftUI
import SwiftData

private enum TravelStyle: String, CaseIterable, Identifiable {
    case budget = "Budget", mid = "Mid-range", comfort = "Comfort"
    var id: String { rawValue }
    var multiplier: Double {
        switch self {
        case .budget: return 1.0
        case .mid: return 1.6
        case .comfort: return 2.5
        }
    }
}

// Cost split used across the app (matches the web calculator).
private let costSplit: [(label: String, pct: Double)] = [
    ("Accommodation", 0.35), ("Food & drink", 0.28), ("Transport", 0.18), ("Activities", 0.19)
]

struct PlannerView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Trip.createdAt, order: .reverse) private var trips: [Trip]

    @State private var destination = DestinationStore.all.first!
    @State private var days = 10
    @State private var style: TravelStyle = .budget
    @State private var saved = false

    private var dailyCost: Double { Double(destination.dailyCost) * style.multiplier }
    private var total: Int { Int((dailyCost * Double(days)).rounded()) }

    var body: some View {
        NavigationStack {
            Form {
                Section("Trip") {
                    Picker("Destination", selection: $destination) {
                        ForEach(DestinationStore.all) { d in
                            Text("\(d.name), \(d.country)").tag(d)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Duration — \(days) day\(days == 1 ? "" : "s")")
                        Slider(value: .init(get: { Double(days) }, set: { days = Int($0) }), in: 3...90, step: 1)
                    }
                    Picker("Travel style", selection: $style) {
                        ForEach(TravelStyle.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Estimated total") {
                    Text("$\(total)")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                        .foregroundStyle(.tint)
                        .contentTransition(.numericText())
                        .animation(.snappy, value: total)
                    ForEach(costSplit, id: \.label) { row in
                        HStack {
                            Text(row.label).foregroundStyle(.secondary)
                            Spacer()
                            Text("$\(Int((Double(total) * row.pct).rounded()))").monospacedDigit()
                        }
                    }
                    HStack {
                        Text("Per day").foregroundStyle(.secondary)
                        Spacer()
                        Text("$\(Int(dailyCost.rounded()))").monospacedDigit()
                    }
                }

                Section {
                    Button {
                        context.insert(Trip(destinationName: destination.name, country: destination.country,
                                            days: days, style: style.rawValue, total: total))
                        saved = true
                    } label: {
                        Label(saved ? "Saved!" : "Save this trip", systemImage: saved ? "checkmark.circle.fill" : "square.and.arrow.down")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }

                if !trips.isEmpty {
                    Section("Saved trips") {
                        ForEach(trips) { t in
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("\(t.destinationName), \(t.country)").font(.headline)
                                    Text("\(t.days) days · \(t.style)").font(.caption).foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text("$\(t.total)").font(.headline.monospacedDigit()).foregroundStyle(.tint)
                            }
                        }
                        .onDelete { idx in idx.forEach { context.delete(trips[$0]) } }
                    }
                }
            }
            .navigationTitle("Budget Planner")
            .onChange(of: destination) { saved = false }
            .onChange(of: days) { saved = false }
            .onChange(of: style) { saved = false }
        }
    }
}
