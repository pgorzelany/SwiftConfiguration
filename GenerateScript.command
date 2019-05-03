#!/bin/bash

BASEDIR=$(dirname $0)
SRC=${BASEDIR}/CommandLineTool/SwiftConfiguration
echo '#!/usr/bin/env xcrun --sdk macosx swift' >  ${BASEDIR}/SwiftConfiguration.swift
cat $SRC/* >> ${BASEDIR}/SwiftConfiguration.swift
