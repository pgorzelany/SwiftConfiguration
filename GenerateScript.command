#!/bin/bash

BASEDIR=$(dirname $0)
SRC=${BASEDIR}/Sources/SwiftConfiguration
echo '#!/usr/bin/env xcrun --sdk macosx swift' >  ${BASEDIR}/SwiftConfigurationGenerator.swift
cat $SRC/* >> ${BASEDIR}/SwiftConfigurationGenerator.swift
