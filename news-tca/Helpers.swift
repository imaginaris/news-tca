import Foundation

enum Helpers {

    private static let dateFormatterServer: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }()
    private static let dateFormatterUI: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    static func formatDateFromServer(_ dateString: String) -> String? {
        guard let date = dateFormatterServer.date(from: dateString) else {
            return nil
        }

        return dateFormatterUI.string(from: date)
    }
}




