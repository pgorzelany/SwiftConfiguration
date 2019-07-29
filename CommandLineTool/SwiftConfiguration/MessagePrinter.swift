
class MessagePrinter {
    /// The warning will show up in compiler build time warnings
    func printWarning(_ items: Any...) {
        for item in items {
            print("warning: \(item)")
        }
    }

    /// The error will show up in compiler build time errors
    func printError(_ items: Any...) {
        for item in items {
            print("error: \(item)")
        }
    }
}
