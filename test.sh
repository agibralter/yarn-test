#!/usr/bin/env bash

npm rm -g yarn >/dev/null 2>&1
npm install -g yarn@0.26.1 >/dev/null 2>&1

function test() {
    echo "---------------------------------------------"
    echo "Running: $1 $2"

    rm -rf node_modules
    rm -rf yarn.lock
    rm -rf cache

    cp .yarnrc-$1 .yarnrc
    cp package-$2.json package.json

    echo ""
    echo "initial install"
    yarn cache clean
    yarn

    rm -rf node_modules

    echo ""
    echo "offline install"
    yarn cache clean
    yarn --offline
    ls cache

    echo ""
    echo "Will yarn add missing packages from cache?"
    rm -rf cache
    yarn cache clean
    yarn
    ls cache

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
