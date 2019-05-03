# SwiftConfiguration

A script and command line tool for fetching, validating and providing a type safe wrapper over configurations in iOS projects.

# Usage

Copy the SwiftConfiguration.swift file into your project structure.
In the target run scripts add a new runscript with the contents:
```
<PATH_TO_SWIFTCONFIGURATION.SWIFT> ${PROJECT_DIR}/${INFOPLIST_FILE} <PATH_TO_CONFIGURATION.PLIST> $CONFIGURATION
```
