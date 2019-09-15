
public class MessagePrinter {

    public init() {}

    /// The warning will show up in compiler build time warnings
    public func printWarning(_ items: Any...) {
        for item in items {
            print("warning: \(item)")
        }
    }

    /// The error will show up in compiler build time errors
    public func printError(_ items: Any...) {
        for item in items {
            print("error: \(item)")
        }
    }
}
