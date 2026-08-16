import SwiftUI

struct ConverterView: View {
    @State private var amountText = "100"
    @State private var from = CurrencyStore.find("USD")
    @State private var to = CurrencyStore.find("THB")

    private var amount: Double { Double(amountText) ?? 0 }
    private var converted: Double { CurrencyStore.convert(amount, from: from, to: to) }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text(from.symbol).foregroundStyle(.secondary).frame(minWidth: 28, alignment: .leading)
                        TextField("Amount", text: $amountText)
                            .keyboardType(.decimalPad)
                            .font(.title2.weight(.semibold))
                    }
                    Picker("From", selection: $from) {
                        ForEach(CurrencyStore.all) { c in
                            Text("\(c.flag)  \(c.code) — \(c.name)").tag(c)
                        }
                    }
                    Picker("To", selection: $to) {
                        ForEach(CurrencyStore.all) { c in
                            Text("\(c.flag)  \(c.code) — \(c.name)").tag(c)
                        }
                    }
                    Button {
                        swap(&from, &to)
                    } label: {
                        Label("Swap currencies", systemImage: "arrow.up.arrow.down")
                    }
                }

                Section("Converted") {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(to.symbol)\(converted, format: .number.precision(.fractionLength(converted >= 100 ? 0 : 2)))")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundStyle(.tint)
                            .contentTransition(.numericText())
                            .animation(.snappy, value: converted)
                        Text("\(amount, format: .number) \(from.code) = \(converted, format: .number.precision(.fractionLength(2))) \(to.code)")
                            .font(.footnote).foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 6)
                }

                Section("1 \(from.code) in other currencies") {
                    ForEach(CurrencyStore.all.filter { $0.code != from.code }.prefix(12)) { c in
                        HStack {
                            Text("\(c.flag)  \(c.code)")
                            Spacer()
                            Text("\(c.symbol)\(CurrencyStore.convert(1, from: from, to: c), format: .number.precision(.fractionLength(2)))")
                                .foregroundStyle(.secondary)
                                .monospacedDigit()
                        }
                    }
                }
            }
            .navigationTitle("Currency Converter")
        }
    }
}
