public struct ParsedArguments {
    public let configurationPlistFilePath: String
    public let outputFilePath: String
}

public class ArgumentsParser {

    public init() {}

    public func parseArguments(_ arguments: [String]) throws -> ParsedArguments {
        guard arguments.count == 3 else {
            throw ConfigurationError(message: "Insufficient number of arguments provided. Refer to the docs.")
        }

        return ParsedArguments(configurationPlistFilePath: arguments[1],
                               outputFilePath: arguments[2])
    }
}
