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

# Build script
Copy the <a href="./SwiftConfigurationGenerator.swift" download>SwiftConfigurationGenerator</a> file into your project structure.

The recommended way to use SwiftConfigurationGenerator is to create a "Run Script" Build Phase (Xcode > Project > Targets > Your build target > Build Phases > New Run Script Phase). This way, the generator will be executed before each build and will ensure the integrity of your configuration wrapper. Be sure to put the script before the "Compile Sources" phase, as it has to generate the code first, before it can be used anywhere else. For convenience, you can just copy the following, and change the configuration appropriately.
```
#Script debugging
set -x

# Get path to SwiftConfigurationGenerator script
SWIFT_CONFIGURATION_GENERATOR_PATH=$PROJECT_DIR/Path_To_Generator/SwiftConfigurationGenerator.swift

# The input configuration file
INPUT_PATH=$PROJECT_DIR/Path_To_Configuration_File/Configuration.plist

# The generated file output path
OUTPUT_PATH=$PROJECT_DIR/Path_To_Generated_Output_file/SwiftConfiguration.generated.swift

# Add permission to generator for script execution
chmod 755 $SWIFT_CONFIGURATION_GENERATOR_PATH

# Execute the script
$SWIFT_CONFIGURATION_GENERATOR_PATH $INPUT_PATH $OUTPUT_PATH

```

Check the example project for an example build phase script.

To select the configuration you want to use, just open your Build Scheme and select one.
![Build scheme setup](./Screenshots/build-scheme.png?raw=true "Build scheme setup")

Once you build the project your configurations files will be validated and the Swift wrapper class generated. **Don't forget to add the generated file to your project sources so you can use it in your code!**

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