#!/usr/bin/env bash

# The --install option supported by autoreconf is designed to pass tool-specific options down to each of the tools that it calls in order to install missing files.
autoreconf --install
# Use automake to copy the missed install-sh
# --copy option indicates that true copies should be made--otherwise, symbolic links are created to the files where the automake package has installed them
automake --add-missing --copy >/dev/null 2>&1
