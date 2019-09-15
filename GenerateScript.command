#!/bin/bash

BASEDIR=$(dirname $0)
SRC=${BASEDIR}/Sources/SwiftConfiguration
EXEC_SRC=${BASEDIR}/Sources/SwiftConfigurationGenerator
echo '#!/usr/bin/env xcrun --sdk macosx swift' >  ${BASEDIR}/SwiftConfigurationGenerator.swift
cat $SRC/* >> ${BASEDIR}/SwiftConfigurationGenerator.swift
cat $EXEC_SRC/* >> ${BASEDIR}/SwiftConfigurationGenerator.swift
sed -i -e 's/import SwiftConfiguration//g' ${BASEDIR}/SwiftConfigurationGenerator.swift
