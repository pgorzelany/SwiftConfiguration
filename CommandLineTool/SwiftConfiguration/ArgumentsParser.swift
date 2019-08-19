import Foundation

struct ParsedArguments {
    let configurationPlistFilePath: String
    let outputFilePath: String
}

class ArgumentsParser {
    func parseArguments(_ arguments: [String]) throws -> ParsedArguments {
        guard arguments.count == 3 else {
            throw ConfigurationError(message: "Insufficient number of arguments provided. Refer to the docs.")
        }

        return ParsedArguments(configurationPlistFilePath: arguments[1],
                               outputFilePath: arguments[2])
    }
}
