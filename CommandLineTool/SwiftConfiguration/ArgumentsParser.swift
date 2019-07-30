import Foundation

struct ParsedArguments {
    let plistFileUrl: URL
    let configurationPlistFileUrl: URL
    let outputFileUrl: URL
    let activeEnvironmentName: String
}

class ArgumentsParser {
    func parseArguments(_ arguments: [String]) throws -> ParsedArguments {
        guard arguments.count == 5 else {
            #warning("Give instructions how to provide the arguments")
            throw ConfigurationError(message: "Insufficient number of arguments provided. Refer to the docs.")
        }

        guard let plistFileUrl = URL(string: arguments[1]) else {
            throw ConfigurationError(message: "\(arguments[1]) is not a valid URL")
        }

        guard let configurationPlistFileUrl = URL(string: arguments[2]) else {
            throw ConfigurationError(message: "\(arguments[2]) is not a valid URL")
        }

        guard let outputFileUrl = URL(string: arguments[3]) else {
            throw ConfigurationError(message: "\(arguments[3]) is not a valid URL")
        }

        return ParsedArguments(plistFileUrl: plistFileUrl,
                               configurationPlistFileUrl: configurationPlistFileUrl,
                               outputFileUrl: outputFileUrl,
                               activeEnvironmentName: CommandLine.arguments[4])
    }
}
