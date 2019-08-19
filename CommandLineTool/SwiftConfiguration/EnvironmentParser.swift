import Foundation

struct Environment {
    let plistFilePath: String
    let activeConfigurationName: String
}

class EnvironmentParser {

    private let processEnvironemnt = ProcessInfo.processInfo.environment

    func parseEnvironment() throws -> Environment {
        guard let activeConfigurationName = processEnvironemnt["CONFIGURATION"] else {
            throw ConfigurationError(message: "Could not obtain the active configuration from the environment variables")
        }

        guard let projectDirectory = processEnvironemnt["PROJECT_DIR"] else {
            throw ConfigurationError(message: "Could not obtain the PROJECT_DIR path from the environment variables")
        }

        guard let relativePlistFilePath = processEnvironemnt["INFOPLIST_FILE"] else {
            throw ConfigurationError(message: "Could not obtain the INFOPLIST_FILE path from the environment variables")
        }

        let plistFilePath = "\(projectDirectory)/\(relativePlistFilePath)"

        return Environment(plistFilePath: plistFilePath, activeConfigurationName: activeConfigurationName)
    }
}
