
struct ParsedArguments {
    let plistFilePath: String
    let configurationPlistFilePath: String
    let outputFilePath: String
    let activeEnvironmentName: String
}

class ArgumentsParser {
    func parseArguments(_ arguments: [String]) throws -> ParsedArguments {
        guard arguments.count == 5 else {
            #warning("Give instructions how to provide the arguments")
            throw ConfigurationError(message: "Insufficient number of arguments provided. Refer to the docs.")
        }

        return ParsedArguments(plistFilePath: CommandLine.arguments[1],
                               configurationPlistFilePath: CommandLine.arguments[2],
                               outputFilePath: CommandLine.arguments[3],
                               activeEnvironmentName: CommandLine.arguments[4])
    }
}
