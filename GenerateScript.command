#!/bin/bash
# helper script used to generate the build phase script SwiftConfigurationGenerator.swift from SPM Sources folder

BASEDIR=$(dirname $0)
SRC=${BASEDIR}/Sources/SwiftConfiguration
EXEC_SRC=${BASEDIR}/Sources/SwiftConfigurationGenerator
echo '#!/usr/bin/env xcrun --sdk macosx swift' >  ${BASEDIR}/SwiftConfigurationGenerator.swift
echo '// A build phase script for fetching, validating and generating a Swift wrapper over configuration files in iOS projects' >>  ${BASEDIR}/SwiftConfigurationGenerator.swift
echo '// Source: https://github.com/pgorzelany/SwiftConfiguration' >>  ${BASEDIR}/SwiftConfigurationGenerator.swift
echo '' >>  ${BASEDIR}/SwiftConfigurationGenerator.swift
cat $SRC/* >> ${BASEDIR}/SwiftConfigurationGenerator.swift
cat $EXEC_SRC/* >> ${BASEDIR}/SwiftConfigurationGenerator.swift
sed -i -e 's/import SwiftConfiguration//g' ${BASEDIR}/SwiftConfigurationGenerator.swift
