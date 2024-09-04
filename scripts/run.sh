#!/usr/bin/env bash
#-*- coding: utf-8 -*-

WORKING_DIR=$(git rev-parse --show-toplevel)
cd $WORKING_DIR || exit

swift build -c release -Xswiftc -cross-module-optimization && \
swift run server serve --hostname 0.0.0.0 --port 8080
