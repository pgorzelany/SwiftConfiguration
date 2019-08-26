# SwiftConfiguration

A build phase script for fetching, validating and generating a type safe wrapper over configuration files in iOS projects.

## The problem
Almost every app nowadays needs to have multiple configurations(environments) that have to be resolved at runtime. Usually we have a dev/staging/prod environment and we define variables that vary between the environments. A good example would be the backend url that will be defferent for each configuration.

The variables are usually stored in a plist/json file which the app accesses through a string API. This is error prone and may crash at runtime if you make a typo of the variable name or you are trying to access a variable that does not exist in the file. There is no safety and no autocomplete involved when accessing the variables.

This script adds safety and convenience by validating the configuration file for errors and generating a type safe Swift wrapper at compile time that you can use to fetch the variables for the current environment at runtime.

## Installation

Just copy the SwiftConfigurationGenerator.swift file to your project. Since this is a build phase script there is currently no support for Cocoapods/Carthage/SwiftPM. 

## Usage

Copy the SwiftConfigurationGenerator.swift file into your project structure.
Add a new run script in the Build Phase:
```
<PATH_TO_SwiftConfigurationGenerator>  <PATH_TO_CONFIGURATION_FILE.PLIST> <GENERATED_WRAPPER_OUTPUT_PATH>
```

Check the example project for an example build phase script.

Example:
```
../SwiftConfigurationGenerator.swift ${PROJECT_DIR}/Example/Configuration.plist ${PROJECT_DIR}/Example/ConfigurationProvider.generated.swift
```

This will take the configuration file at ${PROJECT_DIR}/Example/Configuration.plist (input) validate the configuration file and generate a type safe wrapper over that file at ${PROJECT_DIR}/Example/ConfigurationProvider.generated.swift (output).

Add the generated file to your project sources so you can use it in your code.

## Configuration file format

The program expects the configuration to be in a specific plist file format ([example](Example/Example/Configuration.plist)).
The current supported format of the plist file is:
```
ROOT:
    CONFIGURATION_NAME1:
        PROPERTY1
        PROPERTY2
        ...
    CONFIGURATION_NAME2:
        PROPERTY1
        PROPERTY2
        ...
    CONFIGURATION_NAME3:
        PROPERTY1
        PROPERTY2
        ...
    ....
```

Currently only plist configuration files are supported but if there is demand I can easily add JSON support.

## How it works (a deep dive)
