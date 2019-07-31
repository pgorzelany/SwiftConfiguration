import Foundation

struct ParsedArguments {
    let plistFilePath: String
    let configurationPlistFilePath: String
    let outputFilePath: String
    let activeEnvironmentName: String
}

class ArgumentsParser {
    func parseArguments(_ arguments: [String]) throws -> ParsedArguments {
        guard arguments.count == 5 else {
            throw ConfigurationError(message: "Insufficient number of arguments provided. Refer to the docs.")
        }

        return ParsedArguments(plistFilePath: arguments[1],
                               configurationPlistFilePath: arguments[2],
                               outputFilePath: arguments[3],
                               activeEnvironmentName: CommandLine.arguments[4])
    }
}
