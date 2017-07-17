#!/usr/bin/env bash

# npm rm -g yarn >/dev/null 2>&1
# npm install -g yarn@0.26.1 >/dev/null 2>&1

function test() {
    echo "---------------------------------------------"
    echo "Running: $1 $2"

    yarn cache clean
    rm -rf node_modules
    rm -rf yarn.lock
    rm -rf cache

    cp .yarnrc-$1 .yarnrc
    cp package-$2.json package.json

    echo ""
    echo "Initial install"
    yarn install -s

    echo ""
    echo "Files in cache:"
    files_before="$(ls -la cache)"

    echo ""
    echo "Can we do an offline install? Removing node_modules..."
    rm -rf node_modules
    yarn install -s --offline

    echo ""
    echo "Will yarn add missing packages from cache?"
    rm -rf cache
    yarn install -s
    files_after="$(ls -la cache)"

    if [[ "$files_before" == "$files_after" ]]; then
        echo "FILES MATCH"
    else
        echo "FILES DO NOT MATCH"
        echo $files_before
        echo $files_after
    fi

    rm -rf package.json
    rm -rf .yarnrc
    echo "---------------------------------------------"
    echo ""
}

test "with-pruning" "simple"
test "without-pruning" "simple"

test "with-pruning" "git"
test "without-pruning" "git"

test "with-pruning" "npm-scope"
test "without-pruning" "npm-scope"
