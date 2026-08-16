import Foundation

struct Currency: Identifiable, Hashable {
    let code: String
    let name: String
    let rate: Double   // units per 1 USD
    let symbol: String
    let flag: String
    var id: String { code }
}

enum CurrencyStore {
    static let all: [Currency] = [
        Currency(code: "USD", name: "US Dollar", rate: 1, symbol: "$", flag: "🇺🇸"),
        Currency(code: "GBP", name: "British Pound", rate: 0.79, symbol: "£", flag: "🇬🇧"),
        Currency(code: "EUR", name: "Euro", rate: 0.92, symbol: "€", flag: "🇪🇺"),
        Currency(code: "AUD", name: "Australian Dollar", rate: 1.55, symbol: "A$", flag: "🇦🇺"),
        Currency(code: "CAD", name: "Canadian Dollar", rate: 1.37, symbol: "C$", flag: "🇨🇦"),
        Currency(code: "CHF", name: "Swiss Franc", rate: 0.90, symbol: "Fr", flag: "🇨🇭"),
        Currency(code: "JPY", name: "Japanese Yen", rate: 153, symbol: "¥", flag: "🇯🇵"),
        Currency(code: "CNY", name: "Chinese Yuan", rate: 7.24, symbol: "¥", flag: "🇨🇳"),
        Currency(code: "INR", name: "Indian Rupee", rate: 83.5, symbol: "₹", flag: "🇮🇳"),
        Currency(code: "THB", name: "Thai Baht", rate: 36.5, symbol: "฿", flag: "🇹🇭"),
        Currency(code: "VND", name: "Vietnamese Dong", rate: 25400, symbol: "₫", flag: "🇻🇳"),
        Currency(code: "IDR", name: "Indonesian Rupiah", rate: 16200, symbol: "Rp", flag: "🇮🇩"),
        Currency(code: "MYR", name: "Malaysian Ringgit", rate: 4.72, symbol: "RM", flag: "🇲🇾"),
        Currency(code: "PHP", name: "Philippine Peso", rate: 56.5, symbol: "₱", flag: "🇵🇭"),
        Currency(code: "MMK", name: "Myanmar Kyat", rate: 2100, symbol: "K", flag: "🇲🇲"),
        Currency(code: "KHR", name: "Cambodian Riel", rate: 4070, symbol: "៛", flag: "🇰🇭"),
        Currency(code: "LAK", name: "Lao Kip", rate: 21800, symbol: "₭", flag: "🇱🇦"),
        Currency(code: "NPR", name: "Nepalese Rupee", rate: 133, symbol: "₨", flag: "🇳🇵"),
        Currency(code: "PKR", name: "Pakistani Rupee", rate: 278, symbol: "₨", flag: "🇵🇰"),
        Currency(code: "LKR", name: "Sri Lankan Rupee", rate: 310, symbol: "₨", flag: "🇱🇰"),
        Currency(code: "BDT", name: "Bangladeshi Taka", rate: 110, symbol: "৳", flag: "🇧🇩"),
        Currency(code: "KZT", name: "Kazakhstani Tenge", rate: 451, symbol: "₸", flag: "🇰🇿"),
        Currency(code: "UZS", name: "Uzbekistani Som", rate: 12700, symbol: "soʻm", flag: "🇺🇿"),
        Currency(code: "GEL", name: "Georgian Lari", rate: 2.7, symbol: "₾", flag: "🇬🇪"),
        Currency(code: "AMD", name: "Armenian Dram", rate: 388, symbol: "֏", flag: "🇦🇲"),
        Currency(code: "TRY", name: "Turkish Lira", rate: 32.5, symbol: "₺", flag: "🇹🇷"),
        Currency(code: "JOD", name: "Jordanian Dinar", rate: 0.71, symbol: "JD", flag: "🇯🇴"),
        Currency(code: "OMR", name: "Omani Rial", rate: 0.385, symbol: "OMR", flag: "🇴🇲"),
        Currency(code: "AED", name: "UAE Dirham", rate: 3.67, symbol: "د.إ", flag: "🇦🇪"),
        Currency(code: "SAR", name: "Saudi Riyal", rate: 3.75, symbol: "SR", flag: "🇸🇦"),
        Currency(code: "EGP", name: "Egyptian Pound", rate: 48.5, symbol: "E£", flag: "🇪🇬"),
        Currency(code: "MAD", name: "Moroccan Dirham", rate: 10.05, symbol: "MAD", flag: "🇲🇦"),
        Currency(code: "TZS", name: "Tanzanian Shilling", rate: 2560, symbol: "TSh", flag: "🇹🇿"),
        Currency(code: "KES", name: "Kenyan Shilling", rate: 129, symbol: "KSh", flag: "🇰🇪"),
        Currency(code: "UGX", name: "Ugandan Shilling", rate: 3780, symbol: "USh", flag: "🇺🇬"),
        Currency(code: "ETB", name: "Ethiopian Birr", rate: 57, symbol: "Br", flag: "🇪🇹"),
        Currency(code: "RWF", name: "Rwandan Franc", rate: 1290, symbol: "Fr", flag: "🇷🇼"),
        Currency(code: "GHS", name: "Ghanaian Cedi", rate: 15.5, symbol: "₵", flag: "🇬🇭"),
        Currency(code: "ZAR", name: "South African Rand", rate: 18.6, symbol: "R", flag: "🇿🇦"),
        Currency(code: "COP", name: "Colombian Peso", rate: 3950, symbol: "$", flag: "🇨🇴"),
        Currency(code: "PEN", name: "Peruvian Sol", rate: 3.73, symbol: "S/", flag: "🇵🇪"),
        Currency(code: "ARS", name: "Argentine Peso", rate: 870, symbol: "$", flag: "🇦🇷"),
        Currency(code: "CLP", name: "Chilean Peso", rate: 920, symbol: "$", flag: "🇨🇱"),
        Currency(code: "BRL", name: "Brazilian Real", rate: 5.05, symbol: "R$", flag: "🇧🇷"),
        Currency(code: "MXN", name: "Mexican Peso", rate: 17.2, symbol: "$", flag: "🇲🇽"),
        Currency(code: "GTQ", name: "Guatemalan Quetzal", rate: 7.76, symbol: "Q", flag: "🇬🇹"),
        Currency(code: "BOB", name: "Bolivian Boliviano", rate: 6.91, symbol: "Bs", flag: "🇧🇴"),
        Currency(code: "CUP", name: "Cuban Peso", rate: 24, symbol: "$", flag: "🇨🇺"),
        Currency(code: "PLN", name: "Polish Zloty", rate: 4.05, symbol: "zł", flag: "🇵🇱"),
        Currency(code: "HUF", name: "Hungarian Forint", rate: 360, symbol: "Ft", flag: "🇭🇺"),
        Currency(code: "RON", name: "Romanian Leu", rate: 4.62, symbol: "lei", flag: "🇷🇴"),
        Currency(code: "BGN", name: "Bulgarian Lev", rate: 1.80, symbol: "лв", flag: "🇧🇬"),
        Currency(code: "RSD", name: "Serbian Dinar", rate: 108, symbol: "din", flag: "🇷🇸"),
        Currency(code: "BAM", name: "Bosnia Mark", rate: 1.80, symbol: "KM", flag: "🇧🇦"),
        Currency(code: "ALL", name: "Albanian Lek", rate: 95, symbol: "L", flag: "🇦🇱"),
        Currency(code: "CZK", name: "Czech Koruna", rate: 23.2, symbol: "Kč", flag: "🇨🇿"),
        Currency(code: "HRK", name: "Croatian Kuna", rate: 6.95, symbol: "kn", flag: "🇭🇷"),
    ]
    static func find(_ code: String) -> Currency { all.first { $0.code == code } ?? all[0] }
    /// Convert an amount from one currency to another (both quoted per USD).
    static func convert(_ amount: Double, from: Currency, to: Currency) -> Double {
        (amount / from.rate) * to.rate
    }
}
