# SwiftConfiguration

A build phase script for fetching, validating and generating a Swift wrapper over configuration files in iOS projects.

### Table of contents
- [Why](#why)
- [Installation](#installation)
- [Project setup](#project-setup)
- [Usage](#usage)
- [Configuration file format](#configuration-file-format)
- [How it works](#how-it-works)

## Why
Almost every app nowadays needs to have multiple configurations(environments). Usually we have a dev/staging/prod environment and we define variables that vary between the environments. A good example would be the backend url that will be defferent for each configuration.

The variables are usually stored in a plist/json file which the app accesses through a string API. This is error prone and may crash at runtime if you make a typo of the variable name or you are trying to access a variable that does not exist in the file. There is no safety and no autocomplete involved when accessing the variables.

**This script adds safety and convenience by validating the configuration file for errors and generating a safe Swift wrapper class which you can then use to access the variables at runtime.**

Example code generation:
![Code generation](./Screenshots/code-generation.gif?raw=true "Code generation")

## Installation

Just copy the SwiftConfigurationGenerator.swift file to your project. 
Since this is a build phase script there is currently no support for Cocoapods/Carthage/SwiftPM.

## Project setup
Before using the script you will have to make some additional project setup. First you need to define the configurations that you will be using.

You can do this by clicking on the Project -> Info tab in Xcode (see the below screenshot).
![Project Configuration](./Screenshots/project-configuration.png?raw=true "Project Configuration")

Then you have to create a configuration.plist file that will contain all the variables for the different configurations. The names of the configurations must match the names you previously defined in the project settings (example below). 
![Configuration file](./Screenshots/configuration-file.png?raw=true "Configuration file")

## Usage

Copy the SwiftConfigurationGenerator.swift file into your project structure.
Add a new run script in the Build Phase:
```
<PATH_TO_SwiftConfigurationGenerator.swift>  <PATH_TO_CONFIGURATION_FILE.plist> <GENERATED_WRAPPER_OUTPUT_PATH.swift>
```

Check the example project for an example build phase script.

Example:
![Build phase setup](./Screenshots/build-phase.png?raw=true "Build phase setup")

This will take the configuration file at ${PROJECT_DIR}/Example/Configuration.plist (input) validate the configuration file and generate a type safe wrapper over that file at ${PROJECT_DIR}/Example/ConfigurationProvider.generated.swift (output). 

**Don't forget to add the generated file to your project sources so you can use it in your code!**

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

Currently only plist configuration files are supported but if there is demand I can easily add JSON or xcconfig file support.

## How it works
I described my take on configuration files in [my blog](https://medium.com/@piotr.gorzelany/managing-configuration-dependent-variables-in-ios-projects-b68bfb0f9689). That approach worked but it wasn't very safe since the I was relying on a stringy api for fetching the configuration variables from the files. It was also hard to use since there was no autocomplete.
This script automates some of the setup described in my blog and also validates the configuration files for missing variables and then generates a Swift wrapper class which you can use to safely access the variables using autocomplete.

It does this in a few steps
-  It modifies the Info.plist file to inject a property ($CONFIGURATION) that will be resolved to the current configuration name at runtime.
- It parses the configuration file and turns it into a custom data structure.
- It validates the configuration for missing variables. For example if you have a backend_url defined in your Dev configuration you should also have it defined in other configurations to safely use it. The script makes sure all the variables are well defined. If something is wrong you will get compile time error or warnings.
- After the configuration file passes validation the script generates a Swift wrapper class which you can use to fetch the variables with autocomplete. You don't have to worry about name typos, variables missing in the file or wrong type casts.

** This is the first iteration of this tool and I see a lot of potential to further improve it. If you have any suggestions don't hesitate to open an issue.