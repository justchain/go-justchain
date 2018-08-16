#!/bin/sh

set -e

if [ ! -f "build/env.sh" ]; then
    echo "$0 must be run from the root of the repository."
    exit 2
fi

# Create fake Go workspace if it doesn't exist yet.
workspace="$PWD/build/_workspace"
root="$PWD"
tstdir="$workspace/src/github.com/tstereum"
if [ ! -L "$tstdir/go-tstereum" ]; then
    mkdir -p "$tstdir"
    cd "$tstdir"
    ln -s ../../../../../. go-tstereum
    cd "$root"
fi

# Set up the environment to use the workspace.
GOPATH="$workspace"
export GOPATH

# Run the command inside the workspace.
cd "$tstdir/go-tstereum"
PWD="$tstdir/go-tstereum"

# Launch the arguments with the configured environment.
exec "$@"
